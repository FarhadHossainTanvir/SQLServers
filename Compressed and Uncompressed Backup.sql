--Compressed Backup
	
BACKUP DATABASE [StackOverflow2019] TO
DISK = N'D:\backup\Compressed-Backup.bak'
WITH COMPRESSION, STATS = 10
GO

--Not compressed Backup
	
BACKUP DATABASE [StackOverflow2019] TO
DISK = N'D:\backup\Uncompressed-Backup.bak'
WITH NO_COMPRESSION, STATS = 10
GO

--When you want to restore either of the back-ups, there is no special command for it. The script for the restore operation is the same for both of them. Here is an example of the same.
--Restore Backup
	
RESTORE DATABASE [StackOverflow2019]
FROM DISK = N'D:\backup\Compressed-Backup.bak'
WITH RECOVERY
GO

	
RESTORE DATABASE [StackOverflow2019]
FROM DISK = N'D:\backup\Uncompressed-Backup.bak'
WITH RECOVERY
GO