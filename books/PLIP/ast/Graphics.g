grammar Graphics;

file : command+;// 文件包含多个命令
command : 'line' 'from' point 'to' point;
point : INT ',' INT;
INT : '0'..'9'+;
WS: (' ' | '\t' | '\n'){skip();};