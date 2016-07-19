


	SELECT SERVERPROPERTY('IsFullTextInstalled');

	EXEC sys.sp_help_fulltext_system_components 'filter';

	SELECT document_type, path FROM sys.fulltext_document_types;

	EXEC sys.sp_fulltext_service 'load_os_resources', 1;

	SELECT lcid, name FROM sys.fulltext_languages ORDER BY name;


	/*
		Lesson Review

		1. A
		2.
		3. A
	*/