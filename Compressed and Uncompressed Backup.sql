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

##Performance Difference

--Compress Backup is smaller in size but took a long time to take backup, however, it was quicker to restore.

--No Compress Backup is of the regular size but was faster to take backup, during restore it took a bit longer than compressed backup.