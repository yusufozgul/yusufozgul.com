---
title: Efficiently Transferring Sparse Disk Files Over the Network
date: 2024-10-26 12:00
tags: Swift, APFS, Sparse Files
description: Transferring large files, particularly sparse disk files, over a network can be challenging due to APFS behavior.

---

Transferring large files, particularly sparse disk files, over a network can be challenging due to APFS behavior. Sparse files, commonly used on Apple platforms in Time Machine backups, Virtualization Framework disk images etc., allow large logical sizes without occupying the full physical disk space. In the last six months, I've focused heavily on the Virtualization Framework, and one recurring problem has been efficiently transferring virtual machine (VM) images to other devices over the network. In this post, I’ll share my journey and solutions for making these transfers more efficient.

### What Are Sparse Disk Files?

Sparse files are dynamically allocated files that only consume the amount of physical disk space needed to store actual data, not space. This feature lets you, for example, create a 100-terabyte sparse file on a 256-gigabyte Mac without issues—until you try to transfer it. The problem arises when uploading sparse files to non APFS storage, they expand to their full logical size, this leading to large network data transfer for empty blocks. Imagine uploading a 10-gigabyte sparse file that only uses 1 gigabyte of actual data—it could still require transferring the full 10 gigabytes, effectively wasting bandwidth. This is useless for transferring Virtual Machine disk image to multiple devices.

### Solution Attempts and Results

**Attempt 1: Zip & Unzip**

My initial approach was to compress the entire VM bundle into a single ZIP file and decompress it after transfer. Although this preserved sparse file format, compression was slow and created large files (~50 gigabytes or more), making uploads prone to failure. Restarting an upload again after a failure was frustrating.

**Attempt 2: Split Compressed Files**

To avoid limitations on my storage server and speed up the upload, I split the ZIP file into multiple 1-gigabyte chunks and uploaded them in parallel. This approach improved upload speeds, but the process became lengthy, involving compression, splitting, uploading, downloading, merging, and finally decompression. Although I considered using Apple Archive instead of ZIP, Apple Archive, while faster, but couldn’t handle sparse format while decompression.

**Attempt 3: ReInvent a wheel **

I decided to analyze solutions used in Docker containers and other virtualization applications. Here’s the final approach I developed, which proved effective:

1. **Exclude Empty Disk Sections**: Skip empty sections in the sparse disk file.
2. **Chunk Read**: Process the file in small batches to avoid large memory usage.
3. **Efficient Compression**: Use fast compression algorithms like LZ4.
4. **Deduplicate Files**: Upload unique chunks to reduce redundant data.

Using this approach, I read a 300-gigabyte file in 1-gigabyte chunks, compressing each chunk individually. Out of the 300 files created, only 50 contained unique data, while the rest were duplicate files. By uploading just the unique files, I reduced the transfer size significantly.

The download process simply reversed these steps. First, I downloaded a JSON file with the file structure and empty regions, then fetched only the uploaded files and reconstructed the sparse file.

### Reading Large Files Efficiently in Code

Here’s a sample of how I read large files in Swift without consuming huge memory:

```swift
let mappedFile = try Data(contentsOf: sparseFileUrl, options: [.alwaysMapped])
let compressedData = try (mappedFile as NSData).compressed(using: .lz4) as Data

let decompressed = try data.decompressed(using: .lz4) as Data

```

Using `Data(contentsOf:options:)` with `.alwaysMapped` allows efficient memory mapping of large files, while LZ4 compression provides a fast way to reduce data size before transfer.

### Conclusion

This optimized approach has improved speed and efficiency of transferring VM disk files over the network. By avoiding duplicate data transfers and using an incremental, memory-efficient process, I’ve minimized both bandwidth and storage requirements.