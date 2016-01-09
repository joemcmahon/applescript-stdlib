FasdUAS 1.101.10   ��   ��    k             l      ��  ��   �� TaskLib -- a more powerful alternative to `do shell script`


TO DO: 

- using NSTask asynchronously is a little fiddly: it'll need to be wrapped in a script object for usability, and the user cautioned about not leaving it in a global property/var as `store script` and auto-save won't work due to the object containing an ASOC object (which can't be serialized); although this might be ameliorated by having the script object wrapper only retain the NSTask instance for as long as the subprocess is running (meaning it'll save ok as long as the task isn't still running and the user has called whatever wrapper methods get results out of the NSTask and dispose of it automatically)

- suggest looking at Python's subprocess API in addition to NSTask's own for ideas on how to present the wrapper object's public API

- how much work would it be to include an Expect-style API for request-response communication with interactive processes (e.g. ftp)? probably best left to separate library (see e.g. <http://pexpect.readthedocs.org/en/stable/overview.html>); also, TBH, Expect is itself a lousy hack on par with GUI Scripting, so shouldn't really be encouraged

- Q. would there be any value in wrapping NSUserTask as well?

- Q. how wise/practical would it be to run AS script objects via NSThread+NSAppleScript/OSAKit? (Q. as with FormatLib, is there any way to get an AS script object into OSAKit without ASOC's auto-bridging getting in the way?)

     � 	 	Z   T a s k L i b   - -   a   m o r e   p o w e r f u l   a l t e r n a t i v e   t o   ` d o   s h e l l   s c r i p t ` 
 
 
 T O   D O :   
 
 -   u s i n g   N S T a s k   a s y n c h r o n o u s l y   i s   a   l i t t l e   f i d d l y :   i t ' l l   n e e d   t o   b e   w r a p p e d   i n   a   s c r i p t   o b j e c t   f o r   u s a b i l i t y ,   a n d   t h e   u s e r   c a u t i o n e d   a b o u t   n o t   l e a v i n g   i t   i n   a   g l o b a l   p r o p e r t y / v a r   a s   ` s t o r e   s c r i p t `   a n d   a u t o - s a v e   w o n ' t   w o r k   d u e   t o   t h e   o b j e c t   c o n t a i n i n g   a n   A S O C   o b j e c t   ( w h i c h   c a n ' t   b e   s e r i a l i z e d ) ;   a l t h o u g h   t h i s   m i g h t   b e   a m e l i o r a t e d   b y   h a v i n g   t h e   s c r i p t   o b j e c t   w r a p p e r   o n l y   r e t a i n   t h e   N S T a s k   i n s t a n c e   f o r   a s   l o n g   a s   t h e   s u b p r o c e s s   i s   r u n n i n g   ( m e a n i n g   i t ' l l   s a v e   o k   a s   l o n g   a s   t h e   t a s k   i s n ' t   s t i l l   r u n n i n g   a n d   t h e   u s e r   h a s   c a l l e d   w h a t e v e r   w r a p p e r   m e t h o d s   g e t   r e s u l t s   o u t   o f   t h e   N S T a s k   a n d   d i s p o s e   o f   i t   a u t o m a t i c a l l y ) 
 
 -   s u g g e s t   l o o k i n g   a t   P y t h o n ' s   s u b p r o c e s s   A P I   i n   a d d i t i o n   t o   N S T a s k ' s   o w n   f o r   i d e a s   o n   h o w   t o   p r e s e n t   t h e   w r a p p e r   o b j e c t ' s   p u b l i c   A P I 
 
 -   h o w   m u c h   w o r k   w o u l d   i t   b e   t o   i n c l u d e   a n   E x p e c t - s t y l e   A P I   f o r   r e q u e s t - r e s p o n s e   c o m m u n i c a t i o n   w i t h   i n t e r a c t i v e   p r o c e s s e s   ( e . g .   f t p ) ?   p r o b a b l y   b e s t   l e f t   t o   s e p a r a t e   l i b r a r y   ( s e e   e . g .   < h t t p : / / p e x p e c t . r e a d t h e d o c s . o r g / e n / s t a b l e / o v e r v i e w . h t m l > ) ;   a l s o ,   T B H ,   E x p e c t   i s   i t s e l f   a   l o u s y   h a c k   o n   p a r   w i t h   G U I   S c r i p t i n g ,   s o   s h o u l d n ' t   r e a l l y   b e   e n c o u r a g e d 
 
 -   Q .   w o u l d   t h e r e   b e   a n y   v a l u e   i n   w r a p p i n g   N S U s e r T a s k   a s   w e l l ? 
 
 -   Q .   h o w   w i s e / p r a c t i c a l   w o u l d   i t   b e   t o   r u n   A S   s c r i p t   o b j e c t s   v i a   N S T h r e a d + N S A p p l e S c r i p t / O S A K i t ?   ( Q .   a s   w i t h   F o r m a t L i b ,   i s   t h e r e   a n y   w a y   t o   g e t   a n   A S   s c r i p t   o b j e c t   i n t o   O S A K i t   w i t h o u t   A S O C ' s   a u t o - b r i d g i n g   g e t t i n g   i n   t h e   w a y ? ) 
 
   
  
 l     ��������  ��  ��        l     ��������  ��  ��        x     �� ����    4    �� 
�� 
frmk  m       �    F o u n d a t i o n��        l     ��������  ��  ��        l     ��������  ��  ��        l     ��  ��    J D--------------------------------------------------------------------     �   � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -      l     ��   ��      support      � ! !    s u p p o r t   " # " l     ��������  ��  ��   #  $ % $ l      & ' ( & j    �� )�� 0 _supportlib _supportLib ) N     * * 4    �� +
�� 
scpt + m     , , � - - " L i b r a r y S u p p o r t L i b ' "  used for parameter checking    ( � . . 8   u s e d   f o r   p a r a m e t e r   c h e c k i n g %  / 0 / l     ��������  ��  ��   0  1 2 1 l     ��������  ��  ��   2  3 4 3 i    5 6 5 I      �� 7���� 
0 _error   7  8 9 8 o      ���� 0 handlername handlerName 9  : ; : o      ���� 0 etext eText ;  < = < o      ���� 0 enumber eNumber =  > ? > o      ���� 0 efrom eFrom ?  @�� @ o      ���� 
0 eto eTo��  ��   6 n     A B A I    �� C���� &0 throwcommanderror throwCommandError C  D E D m     F F � G G  T a s k L i b E  H I H o    ���� 0 handlername handlerName I  J K J o    ���� 0 etext eText K  L M L o    	���� 0 enumber eNumber M  N O N o   	 
���� 0 efrom eFrom O  P�� P o   
 ���� 
0 eto eTo��  ��   B o     ���� 0 _supportlib _supportLib 4  Q R Q l     ��������  ��  ��   R  S T S l     ��������  ��  ��   T  U V U l     �� W X��   W J D--------------------------------------------------------------------    X � Y Y � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - V  Z [ Z l     ��������  ��  ��   [  \ ] \ l     ��������  ��  ��   ]  ^ _ ^ l     �� ` a��   `jd TO DO: include optional 'shell script' parameter that, when given, runs `/bin/bash` with {"-c", SCRIPT} as first arguments followed by argumentsList items as normal (these can be accessed as "$0", "$1", etc within shell script; need to think about how best to minimize risk of user screwups, e.g. by automatically applying `quoted form of...` to each arg)    a � b b�   T O   D O :   i n c l u d e   o p t i o n a l   ' s h e l l   s c r i p t '   p a r a m e t e r   t h a t ,   w h e n   g i v e n ,   r u n s   ` / b i n / b a s h `   w i t h   { " - c " ,   S C R I P T }   a s   f i r s t   a r g u m e n t s   f o l l o w e d   b y   a r g u m e n t s L i s t   i t e m s   a s   n o r m a l   ( t h e s e   c a n   b e   a c c e s s e d   a s   " $ 0 " ,   " $ 1 " ,   e t c   w i t h i n   s h e l l   s c r i p t ;   n e e d   t o   t h i n k   a b o u t   h o w   b e s t   t o   m i n i m i z e   r i s k   o f   u s e r   s c r e w u p s ,   e . g .   b y   a u t o m a t i c a l l y   a p p l y i n g   ` q u o t e d   f o r m   o f . . . `   t o   e a c h   a r g ) _  c d c l     ��������  ��  ��   d  e f e l     �� g h��   g : 4 how best to deal with stdin, stdout, stderr, errno?    h � i i h   h o w   b e s t   t o   d e a l   w i t h   s t d i n ,   s t d o u t ,   s t d e r r ,   e r r n o ? f  j k j l     ��������  ��  ��   k  l m l l     �� n o��   n G A include optional boolean param for redirecting stderr to stdout?    o � p p �   i n c l u d e   o p t i o n a l   b o o l e a n   p a r a m   f o r   r e d i r e c t i n g   s t d e r r   t o   s t d o u t ? m  q r q l     ��������  ��  ��   r  s t s l     �� u v��   u @ : option to take environment? (dictionary of string:string)    v � w w t   o p t i o n   t o   t a k e   e n v i r o n m e n t ?   ( d i c t i o n a r y   o f   s t r i n g : s t r i n g ) t  x y x l     ��������  ��  ��   y  z { z l     �� | }��   |�� TO DO: think about implementing asFilePathParameter() that accepts either a file object (alias, furl, etc) or a POSIX path string and returns a POSIX path string; also need an isFileSpecifier(aValue) handler that returns true for alias/furl/etc; alternatively, might consider building this conversion into asTextParameter(), so that filespecs passed as text parameters 'coerce' to POSIX, not HFS, path strings; see also `convert...` handlers in FileLib    } � ~ ~�   T O   D O :   t h i n k   a b o u t   i m p l e m e n t i n g   a s F i l e P a t h P a r a m e t e r ( )   t h a t   a c c e p t s   e i t h e r   a   f i l e   o b j e c t   ( a l i a s ,   f u r l ,   e t c )   o r   a   P O S I X   p a t h   s t r i n g   a n d   r e t u r n s   a   P O S I X   p a t h   s t r i n g ;   a l s o   n e e d   a n   i s F i l e S p e c i f i e r ( a V a l u e )   h a n d l e r   t h a t   r e t u r n s   t r u e   f o r   a l i a s / f u r l / e t c ;   a l t e r n a t i v e l y ,   m i g h t   c o n s i d e r   b u i l d i n g   t h i s   c o n v e r s i o n   i n t o   a s T e x t P a r a m e t e r ( ) ,   s o   t h a t   f i l e s p e c s   p a s s e d   a s   t e x t   p a r a m e t e r s   ' c o e r c e '   t o   P O S I X ,   n o t   H F S ,   p a t h   s t r i n g s ;   s e e   a l s o   ` c o n v e r t . . . `   h a n d l e r s   i n   F i l e L i b {   �  l     ��������  ��  ��   �  � � � l     �� � ���   � � � stdin, stdout, stderr args should be either file object (alias, furl, etc) or POSIX path string indicating a file to read/write, or a script object representing a user-created pipe(?), or a `standard pipe` constant (problem: `standard pipe`)    � � � ��   s t d i n ,   s t d o u t ,   s t d e r r   a r g s   s h o u l d   b e   e i t h e r   f i l e   o b j e c t   ( a l i a s ,   f u r l ,   e t c )   o r   P O S I X   p a t h   s t r i n g   i n d i c a t i n g   a   f i l e   t o   r e a d / w r i t e ,   o r   a   s c r i p t   o b j e c t   r e p r e s e n t i n g   a   u s e r - c r e a t e d   p i p e ( ? ) ,   o r   a   ` s t a n d a r d   p i p e `   c o n s t a n t   ( p r o b l e m :   ` s t a n d a r d   p i p e ` ) �  � � � l     ��������  ��  ��   �  � � � l     �� � ���   � . ( TO DO: what about piping between tasks?    � � � � P   T O   D O :   w h a t   a b o u t   p i p i n g   b e t w e e n   t a s k s ? �  � � � l     ��������  ��  ��   �  � � � l     �� � ���   � � � TO DO: how to deal with pipe's limited size (8K?) buffers? also, -[NSTask isRunning] was removed in 10.9; how to determine current process status?    � � � �&   T O   D O :   h o w   t o   d e a l   w i t h   p i p e ' s   l i m i t e d   s i z e   ( 8 K ? )   b u f f e r s ?   a l s o ,   - [ N S T a s k   i s R u n n i n g ]   w a s   r e m o v e d   i n   1 0 . 9 ;   h o w   t o   d e t e r m i n e   c u r r e n t   p r o c e s s   s t a t u s ? �  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � i    � � � I      �� ����� 0 runtask runTask �  � � � o      ����  0 executablepath executablePath �  ��� � o      ���� 0 argumentslist argumentsList��  ��   � Q     � � � � k    � � �  � � � r     � � � n    � � � I   
 �������� 0 init  ��  ��   � n   
 � � � I    
�������� 	0 alloc  ��  ��   � n    � � � o    ���� 0 nstask NSTask � m    ��
�� misccura � o      ���� 0 thetask theTask �  � � � n   ! � � � I    !�� �����  0 setlaunchpath_ setLaunchPath_ �  ��� � l    ����� � n    � � � I    �� ����� "0 astextparameter asTextParameter �  � � � o    ����  0 executablepath executablePath �  ��� � m     � � � � �  ��  ��   � o    ���� 0 _supportlib _supportLib��  ��  ��  ��   � o    ���� 0 thetask theTask �  � � � l  " "�� � ���   � 6 0 theTask's setCurrentDirectoryPath: inFolderPath    � � � � `   t h e T a s k ' s   s e t C u r r e n t D i r e c t o r y P a t h :   i n F o l d e r P a t h �  � � � r   " / � � � n  " - � � � I   ' -�� ����� "0 aslistparameter asListParameter �  � � � o   ' (���� 0 argumentslist argumentsList �  ��� � m   ( ) � � � � �  u s i n g   a r g u m e n t s��  ��   � o   " '���� 0 _supportlib _supportLib � o      ���� 0 argumentslist argumentsList �  � � � r   0 4 � � � J   0 2����   � o      �� 0 thearguments theArguments �  � � � Y   5 u ��~ � ��} � Q   B p � � � � k   E V � �  � � � l  E E�| � ��|   � � � TO DO: might be an idea to check each arg for ASCII NUL and reject; also, might want to accept file objects as well as strings, automatically converting them to posix path strings    � � � �h   T O   D O :   m i g h t   b e   a n   i d e a   t o   c h e c k   e a c h   a r g   f o r   A S C I I   N U L   a n d   r e j e c t ;   a l s o ,   m i g h t   w a n t   t o   a c c e p t   f i l e   o b j e c t s   a s   w e l l   a s   s t r i n g s ,   a u t o m a t i c a l l y   c o n v e r t i n g   t h e m   t o   p o s i x   p a t h   s t r i n g s �  ��{ � r   E V � � � n  E S � � � I   J S�z ��y�z "0 astextparameter asTextParameter �  � � � n   J N � � � 4   K N�x �
�x 
cobj � o   L M�w�w 0 i   � o   J K�v�v 0 argumentslist argumentsList �  ��u � m   N O � � � � �  u s i n g   a r g u m e n t s�u  �y   � o   E J�t�t 0 _supportlib _supportLib � n       � � �  ;   T U � o   S T�s�s 0 thearguments theArguments�{   � R      �r � �
�r .ascrerr ****      � **** � o      �q�q 0 etext eText � �p � �
�p 
errn � o      �o�o 0 enumber eNumber � �n ��m
�n 
errt � o      �l�l 
0 eto eTo�m   � R   ^ p�k � �
�k .ascrerr ****      � **** � o   n o�j�j 0 etext eText � �i � �
�i 
errn � o   ` a�h�h 0 enumber eNumber � �g � �
�g 
erob � l  b g ��f�e � N   b g � � n   b f � � � 4   c f�d �
�d 
cobj � o   d e�c�c 0 i   � o   b c�b�b 0 argumentslist argumentsList�f  �e   � �a �`
�a 
errt  o   j k�_�_ 
0 eto eTo�`  �~ 0 i   � m   8 9�^�^  � n  9 = 1   : <�]
�] 
leng o   9 :�\�\ 0 argumentslist argumentsList�}   �  n  v | I   w |�[�Z�[ 0 setarguments_ setArguments_ �Y o   w x�X�X 0 thearguments theArguments�Y  �Z   o   v w�W�W 0 thetask theTask 	
	 l  } }�V�U�T�V  �U  �T  
  l  } }�S�S   K E how best to set stdin/stdout/stderr? (may be NSPipe or NSFileHandle)    � �   h o w   b e s t   t o   s e t   s t d i n / s t d o u t / s t d e r r ?   ( m a y   b e   N S P i p e   o r   N S F i l e H a n d l e )  l  } }�R�Q�P�R  �Q  �P    r   } � n  } � I   � ��O�N�O (0 datausingencoding_ dataUsingEncoding_ �M l  � ��L�K n  � � o   � ��J�J ,0 nsutf8stringencoding NSUTF8StringEncoding m   � ��I
�I misccura�L  �K  �M  �N   l  } ��H�G n  } � I   � ��F �E�F &0 stringwithstring_ stringWithString_  !�D! o   � ��C�C 0 	inputtext 	inputText�D  �E   n  } �"#" o   ~ ��B�B 0 nsstring NSString# m   } ~�A
�A misccura�H  �G   o      �@�@ 0 	inputdata 	inputData $%$ l  � ��?�>�=�?  �>  �=  % &'& r   � �()( n  � �*+* I   � ��<�;�:�< 0 pipe  �;  �:  + n  � �,-, o   � ��9�9 0 nspipe NSPipe- m   � ��8
�8 misccura) o      �7�7 0 	inputpipe 	inputPipe' ./. n  � �010 I   � ��62�5�6 &0 setstandardinput_ setStandardInput_2 3�43 o   � ��3�3 0 	inputpipe 	inputPipe�4  �5  1 o   � ��2�2 0 thetask theTask/ 454 r   � �676 n  � �898 I   � ��1�0�/�1 ,0 filehandleforwriting fileHandleForWriting�0  �/  9 o   � ��.�. 0 	inputpipe 	inputPipe7 o      �-�- "0 inputfilehandle inputFileHandle5 :;: l  � ��,�+�*�,  �+  �*  ; <=< l  � ��)�(�'�)  �(  �'  = >?> l  � ��&@A�&  @  e.g. write stdout to pipe, then read it as UTF8-encoded text (might be best to hive off this logic into script objects, similar to ListLib's sort comparators; the only problem being potential ASOC persistence errors if NS objects are retained within them)   A �BB    e . g .   w r i t e   s t d o u t   t o   p i p e ,   t h e n   r e a d   i t   a s   U T F 8 - e n c o d e d   t e x t   ( m i g h t   b e   b e s t   t o   h i v e   o f f   t h i s   l o g i c   i n t o   s c r i p t   o b j e c t s ,   s i m i l a r   t o   L i s t L i b ' s   s o r t   c o m p a r a t o r s ;   t h e   o n l y   p r o b l e m   b e i n g   p o t e n t i a l   A S O C   p e r s i s t e n c e   e r r o r s   i f   N S   o b j e c t s   a r e   r e t a i n e d   w i t h i n   t h e m )? CDC r   � �EFE n  � �GHG I   � ��%�$�#�% 0 pipe  �$  �#  H n  � �IJI o   � ��"�" 0 nspipe NSPipeJ m   � ��!
�! misccuraF o      � �  0 
outputpipe 
outputPipeD KLK n  � �MNM I   � ��O�� (0 setstandardoutput_ setStandardOutput_O P�P o   � ��� 0 
outputpipe 
outputPipe�  �  N o   � ��� 0 thetask theTaskL QRQ l  � �����  �  �  R STS l  � �����  �  �  T UVU n  � �WXW I   � ����� 
0 launch  �  �  X o   � ��� 0 thetask theTaskV YZY l  � �����  �  �  Z [\[ l  � �����  �  �  \ ]^] n  � �_`_ I   � ��
a�	�
 0 
writedata_ 
writeData_a b�b o   � ��� 0 	inputdata 	inputData�  �	  ` o   � ��� "0 inputfilehandle inputFileHandle^ cdc n  � �efe I   � ����� 0 	closefile 	closeFile�  �  f o   � ��� "0 inputfilehandle inputFileHandled ghg l  � ��� ���  �   ��  h iji l  � ���kl��  k � � Q. how best to report process errors? return {returnCode, stderr, stdout} as result, either as standard or as option (with default behavior being to throw error on non-zero return code?)   l �mmv   Q .   h o w   b e s t   t o   r e p o r t   p r o c e s s   e r r o r s ?   r e t u r n   { r e t u r n C o d e ,   s t d e r r ,   s t d o u t }   a s   r e s u l t ,   e i t h e r   a s   s t a n d a r d   o r   a s   o p t i o n   ( w i t h   d e f a u l t   b e h a v i o r   b e i n g   t o   t h r o w   e r r o r   o n   n o n - z e r o   r e t u r n   c o d e ? )j non l  � ���������  ��  ��  o pqp l  � ���rs��  r Y S note: if not blocking on stdout, use theTask's waitUntilExit() to block until done   s �tt �   n o t e :   i f   n o t   b l o c k i n g   o n   s t d o u t ,   u s e   t h e T a s k ' s   w a i t U n t i l E x i t ( )   t o   b l o c k   u n t i l   d o n eq uvu l  � ���������  ��  ��  v wxw l  � ���yz��  y - ' TO DO: what if output buffer fills up?   z �{{ N   T O   D O :   w h a t   i f   o u t p u t   b u f f e r   f i l l s   u p ?x |}| r   � �~~ n  � ���� I   � ��������� ,0 filehandleforreading fileHandleForReading��  ��  � o   � ����� 0 
outputpipe 
outputPipe o      ���� $0 outputfilehandle outputFileHandle} ��� r   � ���� n  � ���� I   � ��������� *0 readdatatoendoffile readDataToEndOfFile��  ��  � o   � ����� $0 outputfilehandle outputFileHandle� o      ���� 0 
outputdata 
outputData� ���� L   � ��� c   � ���� l  � ������� n  � ���� I   � �������� 00 initwithdata_encoding_ initWithData_encoding_� ��� o   � ����� 0 
outputdata 
outputData� ���� l  � ������� n  � ���� o   � ����� ,0 nsutf8stringencoding NSUTF8StringEncoding� m   � ���
�� misccura��  ��  ��  ��  � n  � ���� I   � ��������� 	0 alloc  ��  ��  � n  � ���� o   � ����� 0 nsstring NSString� m   � ���
�� misccura��  ��  � m   � ���
�� 
ctxt��   � R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��   � I  ������� 
0 _error  � ��� m  �� ���  r u n   t a s k� ��� o  	���� 0 etext eText� ��� o  	
���� 0 enumber eNumber� ��� o  
���� 0 efrom eFrom� ���� o  ���� 
0 eto eTo��  ��   � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l    
������ I     
������� 0 runtask runTask� ��� m    �� ���  / b i n / l s� ���� J    �� ��� m    �� ���  - l� ���� m    �� ���  / A p p l i c a t i o n s��  ��  ��  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ���� l     ��������  ��  ��  ��       ����������  � ����������
�� 
pimr�� 0 _supportlib _supportLib�� 
0 _error  �� 0 runtask runTask
�� .aevtoappnull  �   � ****� ����� �  �� �����
�� 
cobj� ��   �� 
�� 
frmk��  � ��   �� ,
�� 
scpt� �� 6���������� 
0 _error  �� ����� �  ������������ 0 handlername handlerName�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo��  � ������������ 0 handlername handlerName�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo�  F������ �� &0 throwcommanderror throwCommandError�� b  ࠡ����+ � �� ����������� 0 runtask runTask�� ����� �  ������  0 executablepath executablePath�� 0 argumentslist argumentsList��  � ����������������������������������  0 executablepath executablePath�� 0 argumentslist argumentsList�� 0 thetask theTask�� 0 thearguments theArguments�� 0 i  �� 0 etext eText�� 0 enumber eNumber�� 
0 eto eTo�� 0 	inputtext 	inputText�� 0 	inputdata 	inputData�� 0 	inputpipe 	inputPipe�� "0 inputfilehandle inputFileHandle�� 0 
outputpipe 
outputPipe�� $0 outputfilehandle outputFileHandle�� 0 
outputdata 
outputData�� 0 efrom eFrom� '������~ ��}�| ��{�z�y ��x��w�v�u�t�s�r�q�p�o�n�m�l�k�j�i�h�g�f�e�d�c���b�a
�� misccura�� 0 nstask NSTask� 	0 alloc  �~ 0 init  �} "0 astextparameter asTextParameter�|  0 setlaunchpath_ setLaunchPath_�{ "0 aslistparameter asListParameter
�z 
leng
�y 
cobj�x 0 etext eText� �`�_�
�` 
errn�_ 0 enumber eNumber� �^�]�\
�^ 
errt�] 
0 eto eTo�\  
�w 
errn
�v 
erob
�u 
errt�t �s 0 setarguments_ setArguments_�r 0 nsstring NSString�q &0 stringwithstring_ stringWithString_�p ,0 nsutf8stringencoding NSUTF8StringEncoding�o (0 datausingencoding_ dataUsingEncoding_�n 0 nspipe NSPipe�m 0 pipe  �l &0 setstandardinput_ setStandardInput_�k ,0 filehandleforwriting fileHandleForWriting�j (0 setstandardoutput_ setStandardOutput_�i 
0 launch  �h 0 
writedata_ 
writeData_�g 0 	closefile 	closeFile�f ,0 filehandleforreading fileHandleForReading�e *0 readdatatoendoffile readDataToEndOfFile�d 00 initwithdata_encoding_ initWithData_encoding_
�c 
ctxt� �[�Z�
�[ 
errn�Z 0 enumber eNumber� �Y�X�
�Y 
erob�X 0 efrom eFrom� �W�V�U
�W 
errt�V 
0 eto eTo�U  �b �a 
0 _error  �� ���,j+ j+ E�O�b  ��l+ k+ Ob  ��l+ E�OjvE�O ?k��,Ekh  b  ��/�l+ �6FW X  )���/a �a �[OY��O��k+ O�a ,�k+ �a ,k+ E�O�a ,j+ E�O��k+ O�j+ E�O�a ,j+ E�O��k+ O�j+ O��k+ O�j+ O�j+ E�O�j+  E�O�a ,j+ ��a ,l+ !a "&W X  #*a $����a %+ &� �T��S�R���Q
�T .aevtoappnull  �   � ****� k     
�� ��P�P  �S  �R  �  � ����O�O 0 runtask runTask�Q *���lvl+ ascr  ��ޭ