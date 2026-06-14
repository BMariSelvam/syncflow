# SyncFlow

Offline Sync + API Retry + Cache Manager for Flutter.

## Features

✅ Offline Request Queue
✅ Auto Retry
✅ Cache Manager
✅ Connectivity Tracking
✅ Auto Sync

## Installation

dependencies:
  syncflow: ^1.0.0

## Usage

await SyncManager.initialize();

await SyncManager.request(
  method: 'POST',
  url: 'https://api.example.com/users',
);

## License

MIT
