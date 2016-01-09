FasdUAS 1.101.10   ��   ��    k             l      ��  ��   60 ListLib -- manipulate AppleScript lists 

Notes:

- To split and join lists [of text], use the `split text` and `join text` commands in TextLib.


TO DO:

- add list lookup speed kludges to everything, durrr; Q. would it be worth just implementing an ArrayCollection object that encapsulates the necessary kludges, and just encouraging users to use that for manipulating lists (in which case some/most of the below handlers might be as well made into methods on that)


- `list comparator` constructor that takes either a single comparator (for comparing all items in an arbitrary-length list) or list of form {{index, comparator},...} (for comparing specific items)

- decide on naming convention for comparator object constructors, e.g. TypesLib uses `make WHATEVER` commands for clarity, but `sort list LIST using (text comparator)` arguably reads better than `sort list LIST using (make text comparator)`


- What other commands are needed?

- `remove duplicates from list LIST` (note: this can be implemented as FilterDuplicatesObject for use in `filter list`; a naive implementation would just build new list and compare against that, giving worst-case O(n^2) performance; however, a smarter implementation could put comparable items into a SetObject, allowing O(n * log n) when filtering lists of numbers, text, dates), caveat considering/ignoring 

- `find in list LIST value VALUE [finding first occurrence/last occurrence/all occurrences]` 

- `transpose list LIST-OF-LISTS`

- `slice list LIST from I to J` -- c.f. `slice text`

- add optional `from [before/after/] item` and `to [before/after/] item` parameters to `insert into list` and `delete from list` to insert/delete ranges; `insert into list` should also be able to replace existing ranges of items with new items (of same or different length)

- stable sorting (perhaps as a boolean option on `sort list`, as speed difference between quicksort and heapsort/etc is likely to be significant)? what about 3-way quicksort (better on lists where most items are equal)?

- might consider using NSMutableArray when sorting simple uniform lists of text or number (would need to compare costs of ASOC bridging vs native sorting to see which performs better); not sure about dates given that they're mutable (ASOC will perform deep copy of list, so resulting list will contain copies of the original date objects, whereas native sort preserves the original date objects); complex values (e.g. list of records) will still be sorted natively, of course (though even there it might be possible to use NSArray to sort an array of [key,valueIndex] and then iterate the result to reposition values in output list, making the [slow] AS part of the code O(2n))


- not sure if the following will be sufficiently useful to justify inclusion (need to identify some concrete use cases, or else discard):

	- `make list [containing INITIAL-VALUE] [size N]` (if INITIAL-VALUE is a reference, dereference it? e.g. `make list containing (a ref to some item of {1,2,3}) size 10`; would probably be simpler to pass an object that generates a random item)
	
	- `make numeric list from MIN to MAX by STEP`?

	- `interlace lists`, `deinterlace lists`? e.g. {{1,2,3},{4,5,6}} <-> {1,4,2,5,3,6}

	- `group into sublists LIST size SUB-LIST-LENGTH [padding...]`, `flatten sublists LIST`? e.g. {1,2,3,4,5,6} size 2 <-> {{1,2},{3,4},{5,6}}
     � 	 	`   L i s t L i b   - -   m a n i p u l a t e   A p p l e S c r i p t   l i s t s   
 
 N o t e s : 
 
 -   T o   s p l i t   a n d   j o i n   l i s t s   [ o f   t e x t ] ,   u s e   t h e   ` s p l i t   t e x t `   a n d   ` j o i n   t e x t `   c o m m a n d s   i n   T e x t L i b . 
 
 
 T O   D O : 
 
 -   a d d   l i s t   l o o k u p   s p e e d   k l u d g e s   t o   e v e r y t h i n g ,   d u r r r ;   Q .   w o u l d   i t   b e   w o r t h   j u s t   i m p l e m e n t i n g   a n   A r r a y C o l l e c t i o n   o b j e c t   t h a t   e n c a p s u l a t e s   t h e   n e c e s s a r y   k l u d g e s ,   a n d   j u s t   e n c o u r a g i n g   u s e r s   t o   u s e   t h a t   f o r   m a n i p u l a t i n g   l i s t s   ( i n   w h i c h   c a s e   s o m e / m o s t   o f   t h e   b e l o w   h a n d l e r s   m i g h t   b e   a s   w e l l   m a d e   i n t o   m e t h o d s   o n   t h a t ) 
 
 
 -   ` l i s t   c o m p a r a t o r `   c o n s t r u c t o r   t h a t   t a k e s   e i t h e r   a   s i n g l e   c o m p a r a t o r   ( f o r   c o m p a r i n g   a l l   i t e m s   i n   a n   a r b i t r a r y - l e n g t h   l i s t )   o r   l i s t   o f   f o r m   { { i n d e x ,   c o m p a r a t o r } , . . . }   ( f o r   c o m p a r i n g   s p e c i f i c   i t e m s ) 
 
 -   d e c i d e   o n   n a m i n g   c o n v e n t i o n   f o r   c o m p a r a t o r   o b j e c t   c o n s t r u c t o r s ,   e . g .   T y p e s L i b   u s e s   ` m a k e   W H A T E V E R `   c o m m a n d s   f o r   c l a r i t y ,   b u t   ` s o r t   l i s t   L I S T   u s i n g   ( t e x t   c o m p a r a t o r ) `   a r g u a b l y   r e a d s   b e t t e r   t h a n   ` s o r t   l i s t   L I S T   u s i n g   ( m a k e   t e x t   c o m p a r a t o r ) ` 
 
 
 -   W h a t   o t h e r   c o m m a n d s   a r e   n e e d e d ? 
 
 -   ` r e m o v e   d u p l i c a t e s   f r o m   l i s t   L I S T `   ( n o t e :   t h i s   c a n   b e   i m p l e m e n t e d   a s   F i l t e r D u p l i c a t e s O b j e c t   f o r   u s e   i n   ` f i l t e r   l i s t ` ;   a   n a i v e   i m p l e m e n t a t i o n   w o u l d   j u s t   b u i l d   n e w   l i s t   a n d   c o m p a r e   a g a i n s t   t h a t ,   g i v i n g   w o r s t - c a s e   O ( n ^ 2 )   p e r f o r m a n c e ;   h o w e v e r ,   a   s m a r t e r   i m p l e m e n t a t i o n   c o u l d   p u t   c o m p a r a b l e   i t e m s   i n t o   a   S e t O b j e c t ,   a l l o w i n g   O ( n   *   l o g   n )   w h e n   f i l t e r i n g   l i s t s   o f   n u m b e r s ,   t e x t ,   d a t e s ) ,   c a v e a t   c o n s i d e r i n g / i g n o r i n g   
 
 -   ` f i n d   i n   l i s t   L I S T   v a l u e   V A L U E   [ f i n d i n g   f i r s t   o c c u r r e n c e / l a s t   o c c u r r e n c e / a l l   o c c u r r e n c e s ] `   
 
 -   ` t r a n s p o s e   l i s t   L I S T - O F - L I S T S ` 
 
 -   ` s l i c e   l i s t   L I S T   f r o m   I   t o   J `   - -   c . f .   ` s l i c e   t e x t ` 
 
 -   a d d   o p t i o n a l   ` f r o m   [ b e f o r e / a f t e r / ]   i t e m `   a n d   ` t o   [ b e f o r e / a f t e r / ]   i t e m `   p a r a m e t e r s   t o   ` i n s e r t   i n t o   l i s t `   a n d   ` d e l e t e   f r o m   l i s t `   t o   i n s e r t / d e l e t e   r a n g e s ;   ` i n s e r t   i n t o   l i s t `   s h o u l d   a l s o   b e   a b l e   t o   r e p l a c e   e x i s t i n g   r a n g e s   o f   i t e m s   w i t h   n e w   i t e m s   ( o f   s a m e   o r   d i f f e r e n t   l e n g t h ) 
 
 -   s t a b l e   s o r t i n g   ( p e r h a p s   a s   a   b o o l e a n   o p t i o n   o n   ` s o r t   l i s t ` ,   a s   s p e e d   d i f f e r e n c e   b e t w e e n   q u i c k s o r t   a n d   h e a p s o r t / e t c   i s   l i k e l y   t o   b e   s i g n i f i c a n t ) ?   w h a t   a b o u t   3 - w a y   q u i c k s o r t   ( b e t t e r   o n   l i s t s   w h e r e   m o s t   i t e m s   a r e   e q u a l ) ? 
 
 -   m i g h t   c o n s i d e r   u s i n g   N S M u t a b l e A r r a y   w h e n   s o r t i n g   s i m p l e   u n i f o r m   l i s t s   o f   t e x t   o r   n u m b e r   ( w o u l d   n e e d   t o   c o m p a r e   c o s t s   o f   A S O C   b r i d g i n g   v s   n a t i v e   s o r t i n g   t o   s e e   w h i c h   p e r f o r m s   b e t t e r ) ;   n o t   s u r e   a b o u t   d a t e s   g i v e n   t h a t   t h e y ' r e   m u t a b l e   ( A S O C   w i l l   p e r f o r m   d e e p   c o p y   o f   l i s t ,   s o   r e s u l t i n g   l i s t   w i l l   c o n t a i n   c o p i e s   o f   t h e   o r i g i n a l   d a t e   o b j e c t s ,   w h e r e a s   n a t i v e   s o r t   p r e s e r v e s   t h e   o r i g i n a l   d a t e   o b j e c t s ) ;   c o m p l e x   v a l u e s   ( e . g .   l i s t   o f   r e c o r d s )   w i l l   s t i l l   b e   s o r t e d   n a t i v e l y ,   o f   c o u r s e   ( t h o u g h   e v e n   t h e r e   i t   m i g h t   b e   p o s s i b l e   t o   u s e   N S A r r a y   t o   s o r t   a n   a r r a y   o f   [ k e y , v a l u e I n d e x ]   a n d   t h e n   i t e r a t e   t h e   r e s u l t   t o   r e p o s i t i o n   v a l u e s   i n   o u t p u t   l i s t ,   m a k i n g   t h e   [ s l o w ]   A S   p a r t   o f   t h e   c o d e   O ( 2 n ) ) 
 
 
 -   n o t   s u r e   i f   t h e   f o l l o w i n g   w i l l   b e   s u f f i c i e n t l y   u s e f u l   t o   j u s t i f y   i n c l u s i o n   ( n e e d   t o   i d e n t i f y   s o m e   c o n c r e t e   u s e   c a s e s ,   o r   e l s e   d i s c a r d ) : 
 
 	 -   ` m a k e   l i s t   [ c o n t a i n i n g   I N I T I A L - V A L U E ]   [ s i z e   N ] `   ( i f   I N I T I A L - V A L U E   i s   a   r e f e r e n c e ,   d e r e f e r e n c e   i t ?   e . g .   ` m a k e   l i s t   c o n t a i n i n g   ( a   r e f   t o   s o m e   i t e m   o f   { 1 , 2 , 3 } )   s i z e   1 0 ` ;   w o u l d   p r o b a b l y   b e   s i m p l e r   t o   p a s s   a n   o b j e c t   t h a t   g e n e r a t e s   a   r a n d o m   i t e m ) 
 	 
 	 -   ` m a k e   n u m e r i c   l i s t   f r o m   M I N   t o   M A X   b y   S T E P ` ? 
 
 	 -   ` i n t e r l a c e   l i s t s ` ,   ` d e i n t e r l a c e   l i s t s ` ?   e . g .   { { 1 , 2 , 3 } , { 4 , 5 , 6 } }   < - >   { 1 , 4 , 2 , 5 , 3 , 6 } 
 
 	 -   ` g r o u p   i n t o   s u b l i s t s   L I S T   s i z e   S U B - L I S T - L E N G T H   [ p a d d i n g . . . ] ` ,   ` f l a t t e n   s u b l i s t s   L I S T ` ?   e . g .   { 1 , 2 , 3 , 4 , 5 , 6 }   s i z e   2   < - >   { { 1 , 2 } , { 3 , 4 } , { 5 , 6 } } 
   
  
 l     ��������  ��  ��        x     
�� ����    2   ��
�� 
osax��        l     ��������  ��  ��        l     ��  ��    J D--------------------------------------------------------------------     �   � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -      l     ��  ��      support     �      s u p p o r t      l     ��������  ��  ��        l         !  j   
 �� "�� 0 _supportlib _supportLib " N   
  # # 4   
 �� $
�� 
scpt $ m     % % � & & " L i b r a r y S u p p o r t L i b   "  used for parameter checking    ! � ' ' 8   u s e d   f o r   p a r a m e t e r   c h e c k i n g   ( ) ( l     ��������  ��  ��   )  * + * i    , - , I      �� .���� 
0 _error   .  / 0 / o      ���� 0 handlername handlerName 0  1 2 1 o      ���� 0 etext eText 2  3 4 3 o      ���� 0 enumber eNumber 4  5 6 5 o      ���� 0 efrom eFrom 6  7�� 7 o      ���� 
0 eto eTo��  ��   - I     �� 8���� 20 _errorwithpartialresult _errorWithPartialResult 8  9 : 9 o    ���� 0 handlername handlerName :  ; < ; o    ���� 0 etext eText <  = > = o    ���� 0 enumber eNumber >  ? @ ? o    ���� 0 efrom eFrom @  A B A o    ���� 
0 eto eTo B  C�� C m    ��
�� 
msng��  ��   +  D E D l     ��������  ��  ��   E  F G F i    H I H I      �� J���� 20 _errorwithpartialresult _errorWithPartialResult J  K L K o      ���� 0 handlername handlerName L  M N M o      ���� 0 etext eText N  O P O o      ���� 0 enumber eNumber P  Q R Q o      ���� 0 efrom eFrom R  S T S o      ���� 
0 eto eTo T  U�� U o      ���� 0 partialresult partialResult��  ��   I n     V W V I    �� X���� 0 rethrowerror rethrowError X  Y Z Y m     [ [ � \ \  L i s t L i b Z  ] ^ ] o    ���� 0 handlername handlerName ^  _ ` _ o    ���� 0 etext eText `  a b a o    	���� 0 enumber eNumber b  c d c o   	 
���� 0 efrom eFrom d  e f e o   
 ���� 
0 eto eTo f  g h g m    ��
�� 
msng h  i�� i o    ���� 0 partialresult partialResult��  ��   W o     ���� 0 _supportlib _supportLib G  j k j l     ��������  ��  ��   k  l m l l     ��������  ��  ��   m  n o n l     �� p q��   p J D--------------------------------------------------------------------    q � r r � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - o  s t s l     ��������  ��  ��   t  u v u l     ��������  ��  ��   v  w x w i    y z y I      �� {���� "0 _makelistobject _makeListObject {  | } | o      ���� 0 len   }  ~�� ~ o      ���� 0 padvalue padValue��  ��   z l    _  � �  k     _ � �  � � � h     �� ��� 0 
listobject 
ListObject � j     �� ��� 0 _   � J     ����   �  � � � Z    Y � ����� � ?     � � � o    	���� 0 len   � m   	 
����   � k    U � �  � � � r     � � � J     � �  � � � o    ���� 0 padvalue padValue �  � � � o    ���� 0 padvalue padValue �  � � � o    ���� 0 padvalue padValue �  ��� � o    ���� 0 padvalue padValue��   � n      � � � o    ���� 0 _   � o    ���� 0 
listobject 
ListObject �  � � � V    5 � � � r   % 0 � � � b   % , � � � n  % ( � � � o   & (���� 0 _   � o   % &���� 0 
listobject 
ListObject � n  ( + � � � o   ) +���� 0 _   � o   ( )���� 0 
listobject 
ListObject � n      � � � o   - /���� 0 _   � o   , -���� 0 
listobject 
ListObject � A    $ � � � n   " � � � 1     "��
�� 
leng � n     � � � o     ���� 0 _   � o    ���� 0 
listobject 
ListObject � o   " #���� 0 len   �  ��� � Z  6 U � ����� � ?   6 = � � � n  6 ; � � � 1   9 ;��
�� 
leng � n  6 9 � � � o   7 9���� 0 _   � o   6 7���� 0 
listobject 
ListObject � o   ; <���� 0 len   � r   @ Q � � � n   @ M � � � 7  C M�� � �
�� 
cobj � m   G I����  � o   J L���� 0 len   � n  @ C � � � o   A C���� 0 _   � o   @ A���� 0 
listobject 
ListObject � n      � � � o   N P���� 0 _   � o   M N���� 0 
listobject 
ListObject��  ��  ��  ��  ��   �  ��� � L   Z _ � � n  Z ^ � � � o   [ ]���� 0 _   � o   Z [���� 0 
listobject 
ListObject��   � J D caution: padValue will not be copied, so should be immutable object    � � � � �   c a u t i o n :   p a d V a l u e   w i l l   n o t   b e   c o p i e d ,   s o   s h o u l d   b e   i m m u t a b l e   o b j e c t x  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l     �� � ���   � J D--------------------------------------------------------------------    � � � � � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - �  � � � l     �� � ���   �   basic operations    � � � � "   b a s i c   o p e r a t i o n s �  � � � l     ��~�}�  �~  �}   �  � � � i     � � � I     �| � �
�| .Lst:Instnull���     **** � o      �{�{ 0 thelist theList � �z � �
�z 
Valu � o      �y�y 0 thevalue theValue � �x � �
�x 
Befo � |�w�v ��u ��w  �v   � o      �t�t 0 beforeindex beforeIndex�u   � m      �s
�s 
msng � �r ��q
�r 
Afte � |�p�o ��n ��p  �o   � o      �m�m 0 
afterindex 
afterIndex�n   � m      �l
�l 
msng�q   � k    0 � �  � � � l     �k � ��k   �.( In addition to inserting before/after the list's actual indexes, this also recognizes three 'virtual' indexes: the `after item` parameter uses index 0 and index `-length - 1` to indicate the start of the list; the `before item` parameter uses index `length + 1` to indicate the end of the list.     � � � �P   I n   a d d i t i o n   t o   i n s e r t i n g   b e f o r e / a f t e r   t h e   l i s t ' s   a c t u a l   i n d e x e s ,   t h i s   a l s o   r e c o g n i z e s   t h r e e   ' v i r t u a l '   i n d e x e s :   t h e   ` a f t e r   i t e m `   p a r a m e t e r   u s e s   i n d e x   0   a n d   i n d e x   ` - l e n g t h   -   1 `   t o   i n d i c a t e   t h e   s t a r t   o f   t h e   l i s t ;   t h e   ` b e f o r e   i t e m `   p a r a m e t e r   u s e s   i n d e x   ` l e n g t h   +   1 `   t o   i n d i c a t e   t h e   e n d   o f   t h e   l i s t .   �  � � � l     �j � ��j   �~x Note that the `before item` parameter cannot indicate the end of a list using a negative index. (Problem: the next 'virtual' index after -1 would be 0, but index 0 is already used by the `after item` parameter to represent the *start* of a list, and it's easier to disallow `before item 0` than explain to user how 'index 0' can be at both the start *and* the end of a list.)    � � � ��   N o t e   t h a t   t h e   ` b e f o r e   i t e m `   p a r a m e t e r   c a n n o t   i n d i c a t e   t h e   e n d   o f   a   l i s t   u s i n g   a   n e g a t i v e   i n d e x .   ( P r o b l e m :   t h e   n e x t   ' v i r t u a l '   i n d e x   a f t e r   - 1   w o u l d   b e   0 ,   b u t   i n d e x   0   i s   a l r e a d y   u s e d   b y   t h e   ` a f t e r   i t e m `   p a r a m e t e r   t o   r e p r e s e n t   t h e   * s t a r t *   o f   a   l i s t ,   a n d   i t ' s   e a s i e r   t o   d i s a l l o w   ` b e f o r e   i t e m   0 `   t h a n   e x p l a i n   t o   u s e r   h o w   ' i n d e x   0 '   c a n   b e   a t   b o t h   t h e   s t a r t   * a n d *   t h e   e n d   o f   a   l i s t . ) �  ��i � Q    0 � � � � k    � �  � � � r     � � � n    � � � I    �h ��g�h "0 aslistparameter asListParameter �  � � � o    	�f�f 0 thelist theList �  �e  m   	 
 �  �e  �g   � o    �d�d 0 _supportlib _supportLib � o      �c�c 0 thelist theList �  Z    � >   	
	 o    �b�b 0 
afterindex 
afterIndex
 m    �a
�a 
msng k    d  Z   '�`�_ >    o    �^�^ 0 beforeindex beforeIndex m    �]
�] 
msng R    #�\
�\ .ascrerr ****      � **** m   ! " � ( T o o   m a n y   p a r a m e t e r s . �[�Z
�[ 
errn m     �Y�Y�Y�Z  �`  �_    r   ( 5 n  ( 3 I   - 3�X�W�X (0 asintegerparameter asIntegerParameter  o   - .�V�V 0 
afterindex 
afterIndex  �U  m   . /!! �""  a f t e r   i t e m�U  �W   o   ( -�T�T 0 _supportlib _supportLib o      �S�S 0 
afterindex 
afterIndex #$# Z  6 I%&�R�Q% A   6 9'(' o   6 7�P�P 0 
afterindex 
afterIndex( m   7 8�O�O  & r   < E)*) [   < C+,+ [   < A-.- l  < ?/�N�M/ n   < ?010 1   = ?�L
�L 
leng1 o   < =�K�K 0 thelist theList�N  �M  . o   ? @�J�J 0 
afterindex 
afterIndex, m   A B�I�I * o      �H�H 0 
afterindex 
afterIndex�R  �Q  $ 2�G2 Z   J d34�F�E3 ?   J O565 o   J K�D�D 0 
afterindex 
afterIndex6 l  K N7�C�B7 n   K N898 1   L N�A
�A 
leng9 o   K L�@�@ 0 thelist theList�C  �B  4 R   R `�?:;
�? .ascrerr ****      � ****: m   ^ _<< �== , I n d e x   i s   o u t   o f   r a n g e .; �>>?
�> 
errn> m   T U�=�=�@? �<@�;
�< 
erob@ l  V ]A�:�9A N   V ]BB n   V \CDC 9   Z \�8
�8 
inslD n   V ZEFE 4   W Z�7G
�7 
cobjG o   X Y�6�6 0 
afterindex 
afterIndexF o   V W�5�5 0 thelist theList�:  �9  �;  �F  �E  �G   HIH >  g jJKJ o   g h�4�4 0 beforeindex beforeIndexK m   h i�3
�3 
msngI L�2L k   m �MM NON r   m zPQP n  m xRSR I   r x�1T�0�1 (0 asintegerparameter asIntegerParameterT UVU o   r s�/�/ 0 beforeindex beforeIndexV W�.W m   s tXX �YY  b e f o r e   i t e m�.  �0  S o   m r�-�- 0 _supportlib _supportLibQ o      �,�, 0 beforeindex beforeIndexO Z[Z Z   { �\]^_\ ?   { ~`a` o   { |�+�+ 0 beforeindex beforeIndexa m   | }�*�*  ] r   � �bcb \   � �ded o   � ��)�) 0 beforeindex beforeIndexe m   � ��(�( c o      �'�' 0 
afterindex 
afterIndex^ fgf A   � �hih o   � ��&�& 0 beforeindex beforeIndexi m   � ��%�%  g j�$j r   � �klk [   � �mnm l  � �o�#�"o n   � �pqp 1   � ��!
�! 
lengq o   � �� �  0 thelist theList�#  �"  n o   � ��� 0 beforeindex beforeIndexl o      �� 0 
afterindex 
afterIndex�$  _ l  � �rstr R   � ��uv
� .ascrerr ****      � ****u m   � �ww �xx  I n v a l i d   i n d e x .v �yz
� 
errny m   � ����@z �{�
� 
erob{ l  � �|��| N   � �}} n   � �~~ 8   � ��
� 
insl n   � ���� 4   � ���
� 
cobj� o   � ��� 0 beforeindex beforeIndex� o   � ��� 0 thelist theList�  �  �  s � � the `before item` parameter cannot identify the end of a list by negative index, so throw 'invalid index' error if `before item 0` is used   t ���   t h e   ` b e f o r e   i t e m `   p a r a m e t e r   c a n n o t   i d e n t i f y   t h e   e n d   o f   a   l i s t   b y   n e g a t i v e   i n d e x ,   s o   t h r o w   ' i n v a l i d   i n d e x '   e r r o r   i f   ` b e f o r e   i t e m   0 `   i s   u s e d[ ��� Z   � ������ G   � ���� ?   � ���� o   � ��� 0 
afterindex 
afterIndex� l  � ����� n   � ���� 1   � ��
� 
leng� o   � ��� 0 thelist theList�  �  � A   � ���� o   � ��
�
 0 
afterindex 
afterIndex� m   � ��	�	  � R   � ����
� .ascrerr ****      � ****� m   � ��� ��� , I n d e x   i s   o u t   o f   r a n g e .� ���
� 
errn� m   � ����@� ���
� 
erob� l  � ����� N   � ��� n   � ���� 8   � ��
� 
insl� n   � ���� 4   � �� �
�  
cobj� o   � ����� 0 beforeindex beforeIndex� o   � ����� 0 thelist theList�  �  �  �  �  �  �2   R   � �����
�� .ascrerr ****      � ****� m   � ��� ��� $ M i s s i n g   p a r a m e t e r .� �����
�� 
errn� m   � ������Y��   ���� Z   ������ =   � ���� o   � ����� 0 
afterindex 
afterIndex� m   � �����  � L   � ��� b   � ���� J   � ��� ���� o   � ����� 0 thevalue theValue��  � o   � ����� 0 thelist theList� ��� =   � ���� o   � ����� 0 
afterindex 
afterIndex� n   � ���� 1   � ���
�� 
leng� o   � ����� 0 thelist theList� ���� L   � ��� b   � ���� o   � ����� 0 thelist theList� J   � ��� ���� o   � ����� 0 thevalue theValue��  ��  � L   ��� b   ���� b   ���� l  ������� n   ���� 7  �����
�� 
cobj� m  ���� � o  ���� 0 
afterindex 
afterIndex� o   � ����� 0 thelist theList��  ��  � J  
�� ���� o  ���� 0 thevalue theValue��  � l ������ n  ��� 7 ����
�� 
cobj� l ������ [  ��� o  ���� 0 
afterindex 
afterIndex� m  ���� ��  ��  � m  ������� o  ���� 0 thelist theList��  ��  ��   � R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��   � I  "0������� 
0 _error  � ��� m  #&�� ���   i n s e r t   i n t o   l i s t� ��� o  &'���� 0 etext eText� ��� o  '(���� 0 enumber eNumber� ��� o  ()���� 0 efrom eFrom� ���� o  )*���� 
0 eto eTo��  ��  �i   � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  ! $��� I     ����
�� .Lst:Delenull���     ****� o      ���� 0 thelist theList� �����
�� 
Inde� |����������  ��  � o      ���� 0 theindex theIndex��  � d      �� m      ���� ��  � Q     ����� k    ��� ��� r    ��� n   ��� I    ������� "0 aslistparameter asListParameter� ��� o    	���� 0 thelist theList� ���� m   	 
�� ���  ��  ��  � o    ���� 0 _supportlib _supportLib� o      ���� 0 thelist theList�    r     n    I    ������ (0 asintegerparameter asIntegerParameter  o    ���� 0 theindex theIndex 	��	 m    

 �  i t e m��  ��   o    ���� 0 _supportlib _supportLib o      ���� 0 theindex theIndex  Z    ��� F    , ?    $ n    " 1     "��
�� 
leng o     ���� 0 thelist theList m   " #����  >   ' * o   ' (���� 0 theindex theIndex m   ( )����   Z   / ��� E  / 9 J   / 5   m   / 0������  !��! n   0 3"#" 1   1 3��
�� 
leng# o   0 1���� 0 thelist theList��   J   5 8$$ %��% o   5 6���� 0 theindex theIndex��   L   < I&& n   < H'(' 7  = G��)*
�� 
cobj) m   A C���� * m   D F������( o   < =���� 0 thelist theList +,+ E  L W-.- J   L S// 010 m   L M���� 1 2��2 d   M Q33 l  M P4����4 n   M P565 1   N P��
�� 
leng6 o   M N���� 0 thelist theList��  ��  ��  . J   S V77 8��8 o   S T���� 0 theindex theIndex��  , 9:9 L   Z _;; n   Z ^<=< 1   [ ]��
�� 
rest= o   Z [���� 0 thelist theList: >?> G   b �@A@ F   b oBCB ?   b eDED o   b c���� 0 theindex theIndexE m   c d����  C A   h mFGF o   h i���� 0 theindex theIndexG n   i lHIH 1   j l��
�� 
lengI o   i j���� 0 thelist theListA F   r �JKJ A   r uLML o   r s���� 0 theindex theIndexM m   s t����  K ?   x ~NON o   x y���� 0 theindex theIndexO d   y }PP l  y |Q����Q n   y |RSR 1   z |��
�� 
lengS o   y z���� 0 thelist theList��  ��  ? T��T L   � �UU b   � �VWV l  � �X����X n   � �YZY 7  � ���[\
�� 
cobj[ m   � ����� \ l  � �]����] \   � �^_^ o   � ����� 0 theindex theIndex_ m   � ����� ��  ��  Z o   � ����� 0 thelist theList��  ��  W l  � �`��~` n   � �aba 7  � ��}cd
�} 
cobjc l  � �e�|�{e [   � �fgf o   � ��z�z 0 theindex theIndexg m   � ��y�y �|  �{  d m   � ��x�x��b o   � ��w�w 0 thelist theList�  �~  ��  ��   hih =   � �jkj n   � �lml 1   � ��v
�v 
lengm o   � ��u�u 0 thelist theListk m   � ��t�t i n�sn Z  � �op�r�qo E  � �qrq J   � �ss tut m   � ��p�p��u v�ov m   � ��n�n �o  r J   � �ww x�mx o   � ��l�l 0 theindex theIndex�m  p L   � �yy J   � ��k�k  �r  �q  �s  ��   z�jz R   � ��i{|
�i .ascrerr ****      � ****{ m   � �}} �~~ : I n v a l i d   i n d e x   ( o u t   o f   r a n g e ) .| �h�
�h 
errn m   � ��g�g�@� �f��e
�f 
erob� l  � ���d�c� N   � ��� n   � ���� 4   � ��b�
�b 
cobj� o   � ��a�a 0 theindex theIndex� o   � ��`�` 0 thelist theList�d  �c  �e  �j  � R      �_��
�_ .ascrerr ****      � ****� o      �^�^ 0 etext eText� �]��
�] 
errn� o      �\�\ 0 enumber eNumber� �[��
�[ 
erob� o      �Z�Z 0 efrom eFrom� �Y��X
�Y 
errt� o      �W�W 
0 eto eTo�X  � I   � ��V��U�V 
0 _error  � ��� m   � ��� ���   d e l e t e   f r o m   l i s t� ��� o   � ��T�T 0 etext eText� ��� o   � ��S�S 0 enumber eNumber� ��� o   � ��R�R 0 efrom eFrom� ��Q� o   � ��P�P 
0 eto eTo�Q  �U  � ��� l     �O�N�M�O  �N  �M  � ��� l     �L�K�J�L  �K  �J  � ��� i   % (��� I     �I��
�I .Lst:Trannull���     ****� o      �H�H 0 thelist theList� �G��
�G 
Whil� |�F�E��D��F  �E  � o      �C�C 0 unevenoption unevenOption�D  � l     ��B�A� m      �@
�@ LTrhLTrR�B  �A  � �?��>
�? 
PadI� |�=�<��;��=  �<  � o      �:�: 0 padvalue padValue�;  � l     ��9�8� m      �7
�7 
msng�9  �8  �>  � Q    ����� k   ��� ��� Z   ���6�5� =   ��� o    �4�4 0 thelist theList� J    �3�3  � L   
 �� J   
 �2�2  �6  �5  � ��� Z   >���1�0� G    /��� =    ��� l   ��/�.� I   �-��
�- .corecnte****       ****� J    �� ��,� o    �+�+ 0 thelist theList�,  � �*��)
�* 
kocl� m    �(
�( 
list�)  �/  �.  � m    �'�'  � >     -��� l    '��&�%� I    '�$��
�$ .corecnte****       ****� o     !�#�# 0 thelist theList� �"��!
�" 
kocl� m   " #� 
�  
list�!  �&  �%  � l  ' ,���� I  ' ,���
� .corecnte****       ****� o   ' (�� 0 thelist theList�  �  �  � R   2 :���
� .ascrerr ****      � ****� m   8 9�� ��� ( N o t   a   l i s t   o f   l i s t s .� ���
� 
errn� m   4 5���Y� ���
� 
erob� o   6 7�� 0 thelist theList�  �1  �0  � ��� h   ? F��� 0 
listobject 
ListObject� j     ��� 0 _  � o     �� 0 thelist theList� ��� r   G Q��� n   G O��� 1   M O�
� 
leng� n  G M��� 4   J M��
� 
cobj� m   K L�� � n  G J��� o   H J�� 0 _  � o   G H�� 0 
listobject 
ListObject� o      �� $0 resultlistlength resultListLength� ��� l  R R����  � K E find the longest/shortest sublist; this will be length of resultList   � ��� �   f i n d   t h e   l o n g e s t / s h o r t e s t   s u b l i s t ;   t h i s   w i l l   b e   l e n g t h   o f   r e s u l t L i s t� ��� Z   R ����� =  R U��� o   R S�
�
 0 unevenoption unevenOption� m   S T�	
�	 LTrhLTrR� X   X ����� Z  j ������ >   j o��� n  j m��� 1   k m�
� 
leng� o   j k�� 0 aref aRef� o   m n�� $0 resultlistlength resultListLength� R   r |���
� .ascrerr ****      � ****� m   x {�� ��� x I n v a l i d   d i r e c t   p a r a m e t e r   ( s u b l i s t s   a r e   n o t   a l l   s a m e   l e n g t h ) .� ���
� 
errn� m   t u� � �Y� �����
�� 
erob� o   v w���� 0 thelist theList��  �  �  � 0 aref aRef� n  [ ^   o   \ ^���� 0 _   o   [ \���� 0 
listobject 
ListObject�  =  � � o   � ����� 0 unevenoption unevenOption m   � ���
�� LTrhLTrP  X   � ���	 Z  � �
����
 ?   � � n  � � 1   � ���
�� 
leng o   � ����� 0 aref aRef o   � ����� $0 resultlistlength resultListLength r   � � n  � � 1   � ���
�� 
leng o   � ����� 0 aref aRef o      ���� $0 resultlistlength resultListLength��  ��  �� 0 aref aRef	 n  � � o   � ����� 0 _   o   � ����� 0 
listobject 
ListObject  =  � � o   � ����� 0 unevenoption unevenOption m   � ���
�� LTrhLTrT �� X   � ��� Z  � ����� A   � �  n  � �!"! 1   � ���
�� 
leng" o   � ����� 0 aref aRef  o   � ����� $0 resultlistlength resultListLength r   � �#$# n  � �%&% 1   � ���
�� 
leng& o   � ����� 0 aref aRef$ o      ���� $0 resultlistlength resultListLength��  ��  �� 0 aref aRef n  � �'(' o   � ����� 0 _  ( o   � ����� 0 
listobject 
ListObject��  � R   � ��)*
�� .ascrerr ****      � ****) m   � �++ �,, h I n v a l i d    w h i l e    p a r a m e t e r   ( n o t   a n   a l l o w e d   c o n s t a n t ) .* ��-.
�� 
errn- m   � ������Y. ��/0
�� 
erob/ o   � ����� 0 unevenoption unevenOption0 ��1��
�� 
errt1 m   � ���
�� 
enum��  � 232 l ��45��  4 � � build empty matrix (due to inefficiencies of AS's list implementation, when populating large lists, it's probably quicker to create a padded list then set its items rather than start with an empty list and append items)   5 �66�   b u i l d   e m p t y   m a t r i x   ( d u e   t o   i n e f f i c i e n c i e s   o f   A S ' s   l i s t   i m p l e m e n t a t i o n ,   w h e n   p o p u l a t i n g   l a r g e   l i s t s ,   i t ' s   p r o b a b l y   q u i c k e r   t o   c r e a t e   a   p a d d e d   l i s t   t h e n   s e t   i t s   i t e m s   r a t h e r   t h a n   s t a r t   w i t h   a n   e m p t y   l i s t   a n d   a p p e n d   i t e m s )3 787 r  9:9 I  ��;���� "0 _makelistobject _makeListObject; <=< n >?> 1  ��
�� 
leng? n @A@ o  ���� 0 _  A o  ���� 0 
listobject 
ListObject= B��B o  ���� 0 padvalue padValue��  ��  : o      ���� (0 emptyresultsublist emptyResultSubList8 CDC h  ��E�� $0 resultlistobject ResultListObjectE j     ��F�� 0 _  F J     ����  D GHG Y  5I��JK��I l '0LMNL r  '0OPO l '+Q����Q e  '+RR n '+STS 2 (*��
�� 
cobjT o  '(���� (0 emptyresultsublist emptyResultSubList��  ��  P n      UVU  ;  ./V n +.WXW o  ,.���� 0 _  X o  +,���� $0 resultlistobject ResultListObjectM   shallow copy   N �YY    s h a l l o w   c o p y�� 0 i  J m  ���� K l "Z����Z \  "[\[ o   ���� $0 resultlistlength resultListLength\ m   !���� ��  ��  ��  H ]^] r  6<_`_ o  67���� (0 emptyresultsublist emptyResultSubList` n      aba  ;  :;b n 7:cdc o  8:���� 0 _  d o  78���� $0 resultlistobject ResultListObject^ efe l ==��gh��  g   populate matrix   h �ii     p o p u l a t e   m a t r i xf jkj Y  ={l��mn��l Y  Lvo��pq��o r  ^qrsr n  ^gtut 4  dg��v
�� 
cobjv o  ef���� 0 j  u n  ^dwxw 4  ad��y
�� 
cobjy o  bc���� 0 i  x n ^az{z o  _a���� 0 _  { o  ^_���� 0 
listobject 
ListObjects n      |}| 4  mp��~
�� 
cobj~ o  no���� 0 i  } n  gm� 4  jm���
�� 
cobj� o  kl���� 0 j  � n gj��� o  hj���� 0 _  � o  gh���� $0 resultlistobject ResultListObject�� 0 j  p m  OP���� q n  PY��� 1  VX��
�� 
leng� n PV��� 4  SV���
�� 
cobj� o  TU���� 0 i  � n PS��� o  QS���� 0 _  � o  PQ���� 0 
listobject 
ListObject��  �� 0 i  m m  @A���� n n AG��� 1  DF��
�� 
leng� n AD��� o  BD���� 0 _  � o  AB���� 0 
listobject 
ListObject��  k ���� L  |��� n |���� o  }���� 0 _  � o  |}���� $0 resultlistobject ResultListObject��  � R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  � I  ��������� 
0 _error  � ��� m  ���� ���  t r a n s p o s e   l i s t� ��� o  ������ 0 etext eText� ��� o  ������ 0 enumber eNumber� ��� o  ������ 0 efrom eFrom� ���� o  ������ 
0 eto eTo��  ��  � ��� l     ��������  ��  ��  � ��� l     ������  � � �transpose list {{1, 2, 3}, {4, 5, 6, 0}, {7, 8, 9}} while padding uneven lists --> {{1, 4, 7}, {2, 5, 8}, {3, 6, 9}, {msng, 0, msng}}   � ���
 t r a n s p o s e   l i s t   { { 1 ,   2 ,   3 } ,   { 4 ,   5 ,   6 ,   0 } ,   { 7 ,   8 ,   9 } }   w h i l e   p a d d i n g   u n e v e n   l i s t s   - - >   { { 1 ,   4 ,   7 } ,   { 2 ,   5 ,   8 } ,   { 3 ,   6 ,   9 } ,   { m s n g ,   0 ,   m s n g } }� ��� l     ������  � U Otranspose list (transpose list {{}, {}}) --> {{missing value}, {missing value}}   � ��� � t r a n s p o s e   l i s t   ( t r a n s p o s e   l i s t   { { } ,   { } } )   - - >   { { m i s s i n g   v a l u e } ,   { m i s s i n g   v a l u e } }� ��� l     ��������  ��  ��  � ��� l     ������  � J D--------------------------------------------------------------------   � ��� � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -� ��� l     ������  �ZT map, filter, reduce (these operations are relatively trivial to perform in AS without the need for callbacks; however, these handlers are more flexible when the convert/check/combine operations are parameterized and also provide more advanced users with idiomatic examples of how to parameterize a general-purpose handler's exact behavior)   � ����   m a p ,   f i l t e r ,   r e d u c e   ( t h e s e   o p e r a t i o n s   a r e   r e l a t i v e l y   t r i v i a l   t o   p e r f o r m   i n   A S   w i t h o u t   t h e   n e e d   f o r   c a l l b a c k s ;   h o w e v e r ,   t h e s e   h a n d l e r s   a r e   m o r e   f l e x i b l e   w h e n   t h e   c o n v e r t / c h e c k / c o m b i n e   o p e r a t i o n s   a r e   p a r a m e t e r i z e d   a n d   a l s o   p r o v i d e   m o r e   a d v a n c e d   u s e r s   w i t h   i d i o m a t i c   e x a m p l e s   o f   h o w   t o   p a r a m e t e r i z e   a   g e n e r a l - p u r p o s e   h a n d l e r ' s   e x a c t   b e h a v i o r )� ��� l     ��������  ��  ��  � ��� l     ������  � � � note: while these handlers prevent the script object from modifying the input list directly, it cannot stop them modifying mutable (date/list/record/script/reference) items within the input list (doing so would be very bad practice, however)   � ����   n o t e :   w h i l e   t h e s e   h a n d l e r s   p r e v e n t   t h e   s c r i p t   o b j e c t   f r o m   m o d i f y i n g   t h e   i n p u t   l i s t   d i r e c t l y ,   i t   c a n n o t   s t o p   t h e m   m o d i f y i n g   m u t a b l e   ( d a t e / l i s t / r e c o r d / s c r i p t / r e f e r e n c e )   i t e m s   w i t h i n   t h e   i n p u t   l i s t   ( d o i n g   s o   w o u l d   b e   v e r y   b a d   p r a c t i c e ,   h o w e v e r )� ��� l     ��~�}�  �~  �}  � ��� i  ) ,��� I     �|��
�| .Lst:Map_null���     ****� o      �{�{ 0 thelist theList� �z��y
�z 
Usin� o      �x�x 0 	thescript 	theScript�y  � k     y�� ��� l    ���� r     ��� J     �w�w  � o      �v�v 0 
resultlist 
resultList��� note: while it'd be slightly quicker to shallow-copy theList and modify that in-place, collecting results in a new list allows error reporting to include a partial result -- TO DO: could still provide partial result by slicing the in-place list up to the item that failed; depending on how efficient AS's array resizing algorithm is (traditionally it scaled terribly), it might be better redoing it; similarly, `filter list` could avoid dynamic resizes by working on shallow copy of original list and just shifting each item left and trimming when done (i.e. O(3n)); need to profile both algorithms for a range of list sizes to determine if difference is significant or not   � ���D   n o t e :   w h i l e   i t ' d   b e   s l i g h t l y   q u i c k e r   t o   s h a l l o w - c o p y   t h e L i s t   a n d   m o d i f y   t h a t   i n - p l a c e ,   c o l l e c t i n g   r e s u l t s   i n   a   n e w   l i s t   a l l o w s   e r r o r   r e p o r t i n g   t o   i n c l u d e   a   p a r t i a l   r e s u l t   - -   T O   D O :   c o u l d   s t i l l   p r o v i d e   p a r t i a l   r e s u l t   b y   s l i c i n g   t h e   i n - p l a c e   l i s t   u p   t o   t h e   i t e m   t h a t   f a i l e d ;   d e p e n d i n g   o n   h o w   e f f i c i e n t   A S ' s   a r r a y   r e s i z i n g   a l g o r i t h m   i s   ( t r a d i t i o n a l l y   i t   s c a l e d   t e r r i b l y ) ,   i t   m i g h t   b e   b e t t e r   r e d o i n g   i t ;   s i m i l a r l y ,   ` f i l t e r   l i s t `   c o u l d   a v o i d   d y n a m i c   r e s i z e s   b y   w o r k i n g   o n   s h a l l o w   c o p y   o f   o r i g i n a l   l i s t   a n d   j u s t   s h i f t i n g   e a c h   i t e m   l e f t   a n d   t r i m m i n g   w h e n   d o n e   ( i . e .   O ( 3 n ) ) ;   n e e d   t o   p r o f i l e   b o t h   a l g o r i t h m s   f o r   a   r a n g e   o f   l i s t   s i z e s   t o   d e t e r m i n e   i f   d i f f e r e n c e   i s   s i g n i f i c a n t   o r   n o t� ��u� Q    y���� k    d�� ��� r    ��� n   ��� I    �t��s�t "0 aslistparameter asListParameter� ��� o    �r�r 0 thelist theList� ��q� m    �� ���  �q  �s  � o    �p�p 0 _supportlib _supportLib� o      �o�o 0 thelist theList� ��� r    #��� n   !��� I    !�n��m�n &0 asscriptparameter asScriptParameter� ��� o    �l�l 0 	thescript 	theScript� ��k� m    �� ��� 
 u s i n g�k  �m  � o    �j�j 0 _supportlib _supportLib� o      �i�i 0 	thescript 	theScript� ��� Q   $ a���� Y   ' E��h���g� l  4 @���� r   4 @� � n  4 = I   5 =�f�e�f 0 convertitem convertItem �d n   5 9 4   6 9�c
�c 
cobj o   7 8�b�b 0 i   o   5 6�a�a 0 thelist theList�d  �e   o   4 5�`�` 0 	thescript 	theScript  n      	  ;   > ?	 o   = >�_�_ 0 
resultlist 
resultList� � ~ use counting loop rather than `repeat with aRef in theList` as the item's index is also used when constructing error messages   � �

 �   u s e   c o u n t i n g   l o o p   r a t h e r   t h a n   ` r e p e a t   w i t h   a R e f   i n   t h e L i s t `   a s   t h e   i t e m ' s   i n d e x   i s   a l s o   u s e d   w h e n   c o n s t r u c t i n g   e r r o r   m e s s a g e s�h 0 i  � m   * +�^�^ � n   + / 1   , .�]
�] 
leng o   + ,�\�\ 0 thelist theList�g  � R      �[
�[ .ascrerr ****      � **** o      �Z�Z 0 etext eText �Y
�Y 
errn o      �X�X 0 enumber eNumber �W�V
�W 
errt o      �U�U 
0 eto eTo�V  � k   M a  l  M M�T�T   � � TO DO: how best to report errors? (AS's lack of stack traces is a pain); for now, use `from` to supply reference to the failed item in the input list    �,   T O   D O :   h o w   b e s t   t o   r e p o r t   e r r o r s ?   ( A S ' s   l a c k   o f   s t a c k   t r a c e s   i s   a   p a i n ) ;   f o r   n o w ,   u s e   ` f r o m `   t o   s u p p l y   r e f e r e n c e   t o   t h e   f a i l e d   i t e m   i n   t h e   i n p u t   l i s t �S R   M a�R
�R .ascrerr ****      � **** b   Y ` b   Y ^ b   Y \  m   Y Z!! �"" * C o u l d n ' t   c o n v e r t   i t e m  o   Z [�Q�Q 0 i   m   \ ]## �$$  :   o   ^ _�P�P 0 etext eText �O%&
�O 
errn% o   O P�N�N 0 enumber eNumber& �M'(
�M 
erob' l  Q V)�L�K) N   Q V** n   Q U+,+ 4   R U�J-
�J 
cobj- o   S T�I�I 0 i  , o   Q R�H�H 0 thelist theList�L  �K  ( �G.�F
�G 
errt. o   W X�E�E 
0 eto eTo�F  �S  � /�D/ L   b d00 o   b c�C�C 0 
resultlist 
resultList�D  � R      �B12
�B .ascrerr ****      � ****1 o      �A�A 0 etext eText2 �@34
�@ 
errn3 o      �?�? 0 enumber eNumber4 �>56
�> 
erob5 o      �=�= 0 efrom eFrom6 �<7�;
�< 
errt7 o      �:�: 
0 eto eTo�;  � I   l y�98�8�9 20 _errorwithpartialresult _errorWithPartialResult8 9:9 m   m p;; �<<  m a p   l i s t: =>= o   p q�7�7 0 etext eText> ?@? o   q r�6�6 0 enumber eNumber@ ABA o   r s�5�5 0 efrom eFromB CDC o   s t�4�4 
0 eto eToD E�3E o   t u�2�2 0 
resultlist 
resultList�3  �8  �u  � FGF l     �1�0�/�1  �0  �/  G HIH l     �.�-�,�.  �-  �,  I JKJ i  - 0LML I     �+NO
�+ .Lst:Filtnull���     ****N o      �*�* 0 thelist theListO �)P�(
�) 
UsinP o      �'�' 0 	thescript 	theScript�(  M k     yQQ RSR r     TUT J     �&�&  U o      �%�% 0 
resultlist 
resultListS V�$V Q    yWXYW k    dZZ [\[ r    ]^] n   _`_ I    �#a�"�# "0 aslistparameter asListParametera bcb o    �!�! 0 thelist theListc d� d m    ee �ff  �   �"  ` o    �� 0 _supportlib _supportLib^ o      �� 0 thelist theList\ ghg r    #iji n   !klk I    !�m�� &0 asscriptparameter asScriptParameterm non o    �� 0 	thescript 	theScripto p�p m    qq �rr 
 u s i n g�  �  l o    �� 0 _supportlib _supportLibj o      �� 0 	thescript 	theScripth sts Q   $ auvwu Y   ' Ex�yz�x r   4 @{|{ n  4 =}~} I   5 =��� 0 	checkitem 	checkItem ��� n   5 9��� 4   6 9��
� 
cobj� o   7 8�� 0 i  � o   5 6�� 0 thelist theList�  �  ~ o   4 5�� 0 	thescript 	theScript| n      ���  ;   > ?� o   = >�� 0 
resultlist 
resultList� 0 i  y m   * +�� z n   + /��� 1   , .�
� 
leng� o   + ,�� 0 thelist theList�  v R      �
��
�
 .ascrerr ****      � ****� o      �	�	 0 etext eText� ���
� 
errn� o      �� 0 enumber eNumber� ���
� 
errt� o      �� 
0 eto eTo�  w R   M a���
� .ascrerr ****      � ****� b   Y `��� b   Y ^��� b   Y \��� m   Y Z�� ��� * C o u l d n ' t   f i l t e r   i t e m  � o   Z [�� 0 i  � m   \ ]�� ���  :  � o   ^ _�� 0 etext eText� � ��
�  
errn� o   O P���� 0 enumber eNumber� ����
�� 
erob� l  Q V������ N   Q V�� n   Q U��� 4   R U���
�� 
cobj� o   S T���� 0 i  � o   Q R���� 0 thelist theList��  ��  � �����
�� 
errt� o   W X���� 
0 eto eTo��  t ���� L   b d�� o   b c���� 0 
resultlist 
resultList��  X R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  Y I   l y������� 20 _errorwithpartialresult _errorWithPartialResult� ��� m   m p�� ���  f i l t e r   l i s t� ��� o   p q���� 0 etext eText� ��� o   q r���� 0 enumber eNumber� ��� o   r s���� 0 efrom eFrom� ��� o   s t���� 
0 eto eTo� ���� o   t u���� 0 
resultlist 
resultList��  ��  �$  K ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  1 4��� I     ����
�� .Lst:Redunull���     ****� o      ���� 0 thelist theList� �����
�� 
Usin� o      ���� 0 	thescript 	theScript��  � k     ��� ��� r     ��� o     ���� 0 missingvalue missingValue� o      ���� 0 	theresult 	theResult� ���� Q    ����� k    ��� ��� r    ��� n   ��� I    ������� "0 aslistparameter asListParameter� ��� o    ���� 0 thelist theList� ���� m    �� ���  ��  ��  � o    ���� 0 _supportlib _supportLib� o      ���� 0 thelist theList� ��� Z   )������� =    ��� n    ��� 1    ��
�� 
leng� o    ���� 0 thelist theList� m    ����  � R    %����
�� .ascrerr ****      � ****� m   # $�� ���  L i s t   i s   e m p t y .� ����
�� 
errn� m     �����Y� �����
�� 
erob� o   ! "���� 0 thelist theList��  ��  ��  � ��� r   * 7��� n  * 5��� I   / 5������� &0 asscriptparameter asScriptParameter� ��� o   / 0���� 0 	thescript 	theScript� ���� m   0 1�� ��� 
 u s i n g��  ��  � o   * /���� 0 _supportlib _supportLib� o      ���� 0 	thescript 	theScript� ��� r   8 >��� n   8 <��� 4   9 <���
�� 
cobj� m   : ;���� � o   8 9���� 0 thelist theList� o      ���� 0 	theresult 	theResult� ��� Q   ? �� � Y   B `���� r   O [ n  O Y I   P Y��	���� 0 combineitems combineItems	 

 o   P Q���� 0 	theresult 	theResult �� n   Q U 4   R U��
�� 
cobj o   S T���� 0 i   o   Q R���� 0 thelist theList��  ��   o   O P���� 0 	thescript 	theScript o      ���� 0 	theresult 	theResult�� 0 i   m   E F����  n   F J 1   G I��
�� 
leng o   F G���� 0 thelist theList��    R      ��
�� .ascrerr ****      � **** o      ���� 0 etext eText ��
�� 
errn o      ���� 0 enumber eNumber ����
�� 
errt o      ���� 
0 eto eTo��   R   h ���
�� .ascrerr ****      � **** b   t  b   t } b   t y m   t w �   * C o u l d n ' t   r e d u c e   i t e m   o   w x���� 0 i   m   y |!! �""  :   o   } ~���� 0 etext eText ��#$
�� 
errn# o   j k���� 0 enumber eNumber$ ��%&
�� 
erob% l  l q'����' N   l q(( n   l p)*) 4   m p��+
�� 
cobj+ o   n o���� 0 i  * o   l m���� 0 thelist theList��  ��  & ��,��
�� 
errt, o   r s���� 
0 eto eTo��  � -��- L   � �.. o   � ����� 0 	theresult 	theResult��  � R      ��/0
�� .ascrerr ****      � ****/ o      ���� 0 etext eText0 ��12
�� 
errn1 o      ���� 0 enumber eNumber2 ��34
�� 
erob3 o      ���� 0 efrom eFrom4 ��5��
�� 
errt5 o      ���� 
0 eto eTo��  � I   � ���6���� 20 _errorwithpartialresult _errorWithPartialResult6 787 m   � �99 �::  r e d u c e   l i s t8 ;<; o   � ����� 0 etext eText< =>= o   � ����� 0 enumber eNumber> ?@? o   � ����� 0 efrom eFrom@ ABA o   � ����� 
0 eto eToB C��C o   � ����� 0 	theresult 	theResult��  ��  ��  � DED l     ��������  ��  ��  E FGF l     ����~��  �  �~  G HIH l     �}JK�}  J J D--------------------------------------------------------------------   K �LL � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -I MNM l     �|OP�|  O   sort   P �QQ 
   s o r tN RSR l     �{�z�y�{  �z  �y  S TUT l      �xVW�x  Vzt Notes: 

- Quicksort provides between [best case] O(n * log n) and [worst case] O(n * n) efficiency, typically leaning towards the former in all but the most pathological cases.

- One limitation of quicksort is that it isn't stable, i.e. items that compare as equal can appear in any order in the resulting list; their original order isn't preserved. An alternate algorithm such as Heapsort would avoid this, but would likely be significantly slower on average (while heapsort is guaranteed to be O(n * log n), it has much higher constant overhead than quicksort which tends to be fast in all but the most degenerate cases).

   W �XX�   N o t e s :   
 
 -   Q u i c k s o r t   p r o v i d e s   b e t w e e n   [ b e s t   c a s e ]   O ( n   *   l o g   n )   a n d   [ w o r s t   c a s e ]   O ( n   *   n )   e f f i c i e n c y ,   t y p i c a l l y   l e a n i n g   t o w a r d s   t h e   f o r m e r   i n   a l l   b u t   t h e   m o s t   p a t h o l o g i c a l   c a s e s . 
 
 -   O n e   l i m i t a t i o n   o f   q u i c k s o r t   i s   t h a t   i t   i s n ' t   s t a b l e ,   i . e .   i t e m s   t h a t   c o m p a r e   a s   e q u a l   c a n   a p p e a r   i n   a n y   o r d e r   i n   t h e   r e s u l t i n g   l i s t ;   t h e i r   o r i g i n a l   o r d e r   i s n ' t   p r e s e r v e d .   A n   a l t e r n a t e   a l g o r i t h m   s u c h   a s   H e a p s o r t   w o u l d   a v o i d   t h i s ,   b u t   w o u l d   l i k e l y   b e   s i g n i f i c a n t l y   s l o w e r   o n   a v e r a g e   ( w h i l e   h e a p s o r t   i s   g u a r a n t e e d   t o   b e   O ( n   *   l o g   n ) ,   i t   h a s   m u c h   h i g h e r   c o n s t a n t   o v e r h e a d   t h a n   q u i c k s o r t   w h i c h   t e n d s   t o   b e   f a s t   i n   a l l   b u t   t h e   m o s t   d e g e n e r a t e   c a s e s ) . 
 
U YZY l     �w�v�u�w  �v  �u  Z [\[ l     �t�s�r�t  �s  �r  \ ]^] i  5 8_`_ I      �qa�p�q 0 _hashandler _hasHandlera b�ob o      �n�n 0 
handlerref 
handlerRef�o  �p  ` Q     cdec l   	fghf k    	ii jkj c    lml o    �m�m 0 
handlerref 
handlerRefm m    �l
�l 
handk n�kn L    	oo m    �j
�j boovtrue�k  g G A horrible hack to check if a script object has a specific handler   h �pp �   h o r r i b l e   h a c k   t o   c h e c k   i f   a   s c r i p t   o b j e c t   h a s   a   s p e c i f i c   h a n d l e rd R      �i�hq
�i .ascrerr ****      � ****�h  q �gr�f
�g 
errnr d      ss m      �e�e��f  e l   tuvt L    ww m    �d
�d boovfalsu   doesn't exist   v �xx    d o e s n ' t   e x i s t^ yzy l     �c�b�a�c  �b  �a  z {|{ l     �`�_�^�`  �_  �^  | }~} i  9 <� I      �]��\�] 	0 _sort  � ��� o      �[�[ 0 keylist keyList� ��� o      �Z�Z 0 	valuelist 	valueList� ��� o      �Y�Y 0 	fromindex 	fromIndex� ��� o      �X�X 0 toindex toIndex� ��� o      �W�W  0 sortcomparator sortComparator� ��V� o      �U�U 0 usequicksort useQuickSort�V  �\  � l   ����� k    ��� ��� l     �T���T  � � � note: this will fall-through to use insertionsort when sorting small number of items, or when sorting a mostly-sorted list, or when quicksort recursion exceeds AS's stack depth; otherwise use quicksort   � ����   n o t e :   t h i s   w i l l   f a l l - t h r o u g h   t o   u s e   i n s e r t i o n s o r t   w h e n   s o r t i n g   s m a l l   n u m b e r   o f   i t e m s ,   o r   w h e n   s o r t i n g   a   m o s t l y - s o r t e d   l i s t ,   o r   w h e n   q u i c k s o r t   r e c u r s i o n   e x c e e d s   A S ' s   s t a c k   d e p t h ;   o t h e r w i s e   u s e   q u i c k s o r t� ��� Z    @���S�R� o     �Q�Q 0 usequicksort useQuickSort� k   <�� ��� r    ��� J    �� ��� o    �P�P 0 	fromindex 	fromIndex� ��O� o    �N�N 0 toindex toIndex�O  � J      �� ��� o      �M�M 0 	leftindex 	leftIndex� ��L� o      �K�K 0 
rightindex 
rightIndex�L  � ��� l   ���� r    ��� n    ��� 3    �J
�J 
cobj� o    �I�I 0 keylist keyList� o      �H�H 0 
pivotvalue 
pivotValue� s m TO DO: if valueList's length>someThreshold then use median of 3 items (or 9 in the case of very large lists)   � ��� �   T O   D O :   i f   v a l u e L i s t ' s   l e n g t h > s o m e T h r e s h o l d   t h e n   u s e   m e d i a n   o f   3   i t e m s   ( o r   9   i n   t h e   c a s e   o f   v e r y   l a r g e   l i s t s )� ��� V   ��� k   &�� ��� Q   & `���� V   ) F��� l  < A���� r   < A��� [   < ?��� o   < =�G�G 0 	leftindex 	leftIndex� m   = >�F�F � o      �E�E 0 	leftindex 	leftIndex� � } while cmp returns -1; note that if compareObjects() returns a non-numeric value/no result, this will throw -1700/-2763 error   � ��� �   w h i l e   c m p   r e t u r n s   - 1 ;   n o t e   t h a t   i f   c o m p a r e O b j e c t s ( )   r e t u r n s   a   n o n - n u m e r i c   v a l u e / n o   r e s u l t ,   t h i s   w i l l   t h r o w   - 1 7 0 0 / - 2 7 6 3   e r r o r� A   - ;��� c   - 9��� n  - 7��� I   . 7�D��C�D  0 compareobjects compareObjects� ��� n   . 2��� 4   / 2�B�
�B 
cobj� o   0 1�A�A 0 	leftindex 	leftIndex� o   . /�@�@ 0 keylist keyList� ��?� o   2 3�>�> 0 
pivotvalue 
pivotValue�?  �C  � o   - .�=�=  0 sortcomparator sortComparator� m   7 8�<
�< 
nmbr� m   9 :�;�;  � R      �:��
�: .ascrerr ****      � ****� o      �9�9 0 etext eText� �8��
�8 
errn� o      �7�7 0 enum eNum� �6��
�6 
erob� o      �5�5 0 efrom eFrom� �4��3
�4 
errt� o      �2�2 
0 eto eTo�3  � R   N `�1��
�1 .ascrerr ****      � ****� b   \ _��� m   \ ]�� ��� < C o u l d n ' t   c o m p a r e   o b j e c t   k e y s :  � o   ] ^�0�0 0 etext eText� �/��
�/ 
errn� o   P Q�.�. 0 enum eNum� �-��
�- 
erob� J   R Y�� ��� n   R V��� 4   S V�,�
�, 
cobj� o   T U�+�+ 0 	leftindex 	leftIndex� o   R S�*�* 0 keylist keyList� ��)� o   V W�(�( 0 
pivotvalue 
pivotValue�)  � �'��&
�' 
errt� o   Z [�%�% 
0 eto eTo�&  � ��� Q   a ����� V   d ���� l  w |���� r   w |��� \   w z��� o   w x�$�$ 0 
rightindex 
rightIndex� m   x y�#�# � o      �"�" 0 
rightindex 
rightIndex�   while cmp returns 1;    � ��� ,   w h i l e   c m p   r e t u r n s   1 ;  � ?   h v��� c   h t��� n  h r��� I   i r�! � �!  0 compareobjects compareObjects   n   i m 4   j m�
� 
cobj o   k l�� 0 
rightindex 
rightIndex o   i j�� 0 keylist keyList � o   m n�� 0 
pivotvalue 
pivotValue�  �   � o   h i��  0 sortcomparator sortComparator� m   r s�
� 
nmbr� m   t u��  � R      �
� .ascrerr ****      � **** o      �� 0 etext eText �	

� 
errn	 o      �� 0 enum eNum
 �
� 
erob o      �� 0 efrom eFrom ��
� 
errt o      �� 
0 eto eTo�  � R   � ��
� .ascrerr ****      � **** b   � � m   � � � < C o u l d n ' t   c o m p a r e   o b j e c t   k e y s :   o   � ��� 0 etext eText �
� 
errn o   � ��� 0 enum eNum �

�
 
erob J   � �  n   � � 4   � ��	
�	 
cobj o   � ��� 0 
rightindex 
rightIndex o   � ��� 0 keylist keyList � o   � ��� 0 
pivotvalue 
pivotValue�   ��
� 
errt o   � ��� 
0 eto eTo�  �  �  Z   �!"� ��! l  � �#����# H   � �$$ ?   � �%&% o   � ����� 0 	leftindex 	leftIndex& o   � ����� 0 
rightindex 
rightIndex��  ��  " k   �'' ()( O  � �*+* r   � �,-, J   � �.. /0/ 4   � ���1
�� 
cobj1 o   � ����� 0 
rightindex 
rightIndex0 2��2 4   � ���3
�� 
cobj3 o   � ����� 0 	leftindex 	leftIndex��  - J      44 565 4   � ���7
�� 
cobj7 o   � ����� 0 	leftindex 	leftIndex6 8��8 4   � ���9
�� 
cobj9 o   � ����� 0 
rightindex 
rightIndex��  + o   � ����� 0 keylist keyList) :;: O  � �<=< r   � �>?> J   � �@@ ABA 4   � ���C
�� 
cobjC o   � ����� 0 
rightindex 
rightIndexB D��D 4   � ���E
�� 
cobjE o   � ����� 0 	leftindex 	leftIndex��  ? J      FF GHG 4   � ���I
�� 
cobjI o   � ����� 0 	leftindex 	leftIndexH J��J 4   � ���K
�� 
cobjK o   � ����� 0 
rightindex 
rightIndex��  = o   � ����� 0 	valuelist 	valueList; L��L r   �MNM J   � �OO PQP [   � �RSR o   � ����� 0 	leftindex 	leftIndexS m   � ����� Q T��T \   � �UVU o   � ����� 0 
rightindex 
rightIndexV m   � ����� ��  N J      WW XYX o      ���� 0 	leftindex 	leftIndexY Z��Z o      ���� 0 
rightindex 
rightIndex��  ��  �   ��  �  � B   " %[\[ o   " #���� 0 	leftindex 	leftIndex\ o   # $���� 0 
rightindex 
rightIndex� ]��] Q  <^_`^ k  3aa bcb l ��de��  d � � the following calls will use insertionsort instead of quicksort when sorting �10 items, as insertionsort, while typically less efficient than quicksort, has a lower constant overhead   e �ffn   t h e   f o l l o w i n g   c a l l s   w i l l   u s e   i n s e r t i o n s o r t   i n s t e a d   o f   q u i c k s o r t   w h e n   s o r t i n g  "d 1 0   i t e m s ,   a s   i n s e r t i o n s o r t ,   w h i l e   t y p i c a l l y   l e s s   e f f i c i e n t   t h a n   q u i c k s o r t ,   h a s   a   l o w e r   c o n s t a n t   o v e r h e a dc ghg I   ��i���� 	0 _sort  i jkj o  ���� 0 keylist keyListk lml o  ���� 0 	valuelist 	valueListm non o  ���� 0 	fromindex 	fromIndexo pqp o  ���� 0 
rightindex 
rightIndexq rsr o  ����  0 sortcomparator sortComparators t��t ?  uvu \  wxw o  ���� 0 
rightindex 
rightIndexx o  ���� 0 	fromindex 	fromIndexv m  ���� 
��  ��  h yzy I  !0��{���� 	0 _sort  { |}| o  "#���� 0 keylist keyList} ~~ o  #$���� 0 	valuelist 	valueList ��� o  $%���� 0 	leftindex 	leftIndex� ��� o  %&���� 0 toindex toIndex� ��� o  &'����  0 sortcomparator sortComparator� ���� ?  ',��� \  '*��� o  '(���� 0 toindex toIndex� o  ()���� 0 	leftindex 	leftIndex� m  *+���� 
��  ��  z ���� L  13����  ��  _ R      �����
�� .ascrerr ****      � ****��  � �����
�� 
errn� d      �� m      ����
���  ` l ;;������  � J D stack overflow, so fall-through to use non-recursive insertion sort   � ��� �   s t a c k   o v e r f l o w ,   s o   f a l l - t h r o u g h   t o   u s e   n o n - r e c u r s i v e   i n s e r t i o n   s o r t��  �S  �R  � ��� l AA������  � � � fall-through to use loop-based insertion sort when sorting a small number of items (for which it is faster than quicksort), or when quicksort recursion overflows AppleScript's call stack   � ���v   f a l l - t h r o u g h   t o   u s e   l o o p - b a s e d   i n s e r t i o n   s o r t   w h e n   s o r t i n g   a   s m a l l   n u m b e r   o f   i t e m s   ( f o r   w h i c h   i t   i s   f a s t e r   t h a n   q u i c k s o r t ) ,   o r   w h e n   q u i c k s o r t   r e c u r s i o n   o v e r f l o w s   A p p l e S c r i p t ' s   c a l l   s t a c k� ��� r  AF��� [  AD��� o  AB���� 0 	fromindex 	fromIndex� m  BC���� � o      ���� 0 	fromindex 	fromIndex� ���� Y  G��������� Y  Q�������� k  [��� ��� r  [x��� J  [g�� ��� n  [a��� 4  \a���
�� 
cobj� l ]`������ \  ]`��� o  ]^���� 0 j  � m  ^_���� ��  ��  � o  [\���� 0 keylist keyList� ���� n  ae��� 4  be���
�� 
cobj� o  cd���� 0 j  � o  ab���� 0 keylist keyList��  � J      �� ��� o      ���� 0 leftkey leftKey� ���� o      ���� 0 rightkey rightKey��  � ��� l y����� Z y�������� A  y���� n y���� I  z��������  0 compareobjects compareObjects� ��� o  z{���� 0 leftkey leftKey� ���� o  {~���� 0 rightkey rightKey��  ��  � o  yz����  0 sortcomparator sortComparator� m  ������ �  S  ����  ��  � !  stop when leftKey�rightKey   � ��� 6   s t o p   w h e n   l e f t K e y"d r i g h t K e y� ��� r  ����� J  ���� ��� o  ������ 0 rightkey rightKey� ���� o  ������ 0 leftkey leftKey��  � J      �� ��� n      ��� 4  �����
�� 
cobj� l �������� \  ����� o  ������ 0 j  � m  ������ ��  ��  � o  ������ 0 keylist keyList� ���� n      ��� 4  �����
�� 
cobj� o  ������ 0 j  � o  ������ 0 keylist keyList��  � ���� r  ����� J  ���� ��� n  ����� 4  �����
�� 
cobj� o  ������ 0 j  � o  ������ 0 	valuelist 	valueList� ���� n  ����� 4  �����
�� 
cobj� l �������� \  ����� o  ������ 0 j  � m  ������ ��  ��  � o  ������ 0 	valuelist 	valueList��  � J      �� ��� n      ��� 4  �����
�� 
cobj� l �������� \  ����� o  ������ 0 j  � m  ���� ��  ��  � o  ���~�~ 0 	valuelist 	valueList� ��}� n      ��� 4  ���|�
�| 
cobj� o  ���{�{ 0 j  � o  ���z�z 0 	valuelist 	valueList�}  ��  �� 0 j  � o  TU�y�y 0 i  � o  UV�x�x 0 	fromindex 	fromIndex� m  VW�w�w���� 0 i  � o  JK�v�v 0 	fromindex 	fromIndex� o  KL�u�u 0 toindex toIndex��  ��  � 0 * performs in-place quicksort/insertionsort   � ��� T   p e r f o r m s   i n - p l a c e   q u i c k s o r t / i n s e r t i o n s o r t~ ��� l     �t�s�r�t  �s  �r  �    l     �q�p�o�q  �p  �o    l     �n�m�l�n  �m  �l    i  = @ I     �k	
�k .Lst:Sortnull���     **** o      �j�j 0 thelist theList	 �i
�h
�i 
Comp
 |�g�f�e�g  �f   o      �d�d $0 comparatorobject comparatorObject�e   m      �c
�c 
msng�h   k    �  l     �b�b  1+ note that `sort list` currently doesn't implement a `reversed order` parameter as its quicksort algorithm isn't stable (i.e. items that compare as equal will appear in any order, not the order in which they were supplied), so such an option would be useless in practice and rather misleading too. (To get a list in descending order, just get the returned list's `reverse` property or else pass a comparator containing a suitable compareObjects handler.) This parameter can always be added in future if/when a stable sorting algorithm is ever implemented.    �V   n o t e   t h a t   ` s o r t   l i s t `   c u r r e n t l y   d o e s n ' t   i m p l e m e n t   a   ` r e v e r s e d   o r d e r `   p a r a m e t e r   a s   i t s   q u i c k s o r t   a l g o r i t h m   i s n ' t   s t a b l e   ( i . e .   i t e m s   t h a t   c o m p a r e   a s   e q u a l   w i l l   a p p e a r   i n   a n y   o r d e r ,   n o t   t h e   o r d e r   i n   w h i c h   t h e y   w e r e   s u p p l i e d ) ,   s o   s u c h   a n   o p t i o n   w o u l d   b e   u s e l e s s   i n   p r a c t i c e   a n d   r a t h e r   m i s l e a d i n g   t o o .   ( T o   g e t   a   l i s t   i n   d e s c e n d i n g   o r d e r ,   j u s t   g e t   t h e   r e t u r n e d   l i s t ' s   ` r e v e r s e `   p r o p e r t y   o r   e l s e   p a s s   a   c o m p a r a t o r   c o n t a i n i n g   a   s u i t a b l e   c o m p a r e O b j e c t s   h a n d l e r . )   T h i s   p a r a m e t e r   c a n   a l w a y s   b e   a d d e d   i n   f u t u r e   i f / w h e n   a   s t a b l e   s o r t i n g   a l g o r i t h m   i s   e v e r   i m p l e m e n t e d .  l     r      J     �a�a   o      �`�` 0 
resultlist 
resultList S M (only needed to keep the `on error` clause at the end of this handler happy)    � �   ( o n l y   n e e d e d   t o   k e e p   t h e   ` o n   e r r o r `   c l a u s e   a t   t h e   e n d   o f   t h i s   h a n d l e r   h a p p y ) �_ Q   � k   �  !  r    "#" n    $%$ 2   �^
�^ 
cobj% n   &'& I    �](�\�] "0 aslistparameter asListParameter( )*) o    �[�[ 0 thelist theList* +�Z+ m    ,, �--  �Z  �\  ' o    �Y�Y 0 _supportlib _supportLib# o      �X�X 0 
resultlist 
resultList! ./. Z   &01�W�V0 A    232 n   454 1    �U
�U 
leng5 o    �T�T 0 
resultlist 
resultList3 m    �S�S 1 L     "66 o     !�R�R 0 
resultlist 
resultList�W  �V  / 787 Z   ' D9:�Q;9 =  ' *<=< o   ' (�P�P $0 comparatorobject comparatorObject= m   ( )�O
�O 
msng: r   - 4>?> I   - 2�N�M�L�N 00 _makedefaultcomparator _makeDefaultComparator�M  �L  ? o      �K�K  0 sortcomparator sortComparator�Q  ; r   7 D@A@ n  7 BBCB I   < B�JD�I�J &0 asscriptparameter asScriptParameterD EFE o   < =�H�H $0 comparatorobject comparatorObjectF G�GG m   = >HH �II 
 u s i n g�G  �I  C o   7 <�F�F 0 _supportlib _supportLibA o      �E�E  0 sortcomparator sortComparator8 JKJ l  E E�DLM�D  L�} note: the quickest way to check types is (count {resultList} each number/text/date) = length of resultList; could also accept number/text/date in `using` and create default comparator according to that; OTOH, a benefit of this extra O(n) pass is that we can check if list is already sorted or almost sorted and return immediately or use insertionsort instead of quicksort if it is   M �NN�   n o t e :   t h e   q u i c k e s t   w a y   t o   c h e c k   t y p e s   i s   ( c o u n t   { r e s u l t L i s t }   e a c h   n u m b e r / t e x t / d a t e )   =   l e n g t h   o f   r e s u l t L i s t ;   c o u l d   a l s o   a c c e p t   n u m b e r / t e x t / d a t e   i n   ` u s i n g `   a n d   c r e a t e   d e f a u l t   c o m p a r a t o r   a c c o r d i n g   t o   t h a t ;   O T O H ,   a   b e n e f i t   o f   t h i s   e x t r a   O ( n )   p a s s   i s   t h a t   w e   c a n   c h e c k   i f   l i s t   i s   a l r e a d y   s o r t e d   o r   a l m o s t   s o r t e d   a n d   r e t u r n   i m m e d i a t e l y   o r   u s e   i n s e r t i o n s o r t   i n s t e a d   o f   q u i c k s o r t   i f   i t   i sK OPO l  E E�C�B�A�C  �B  �A  P QRQ l  E E�@ST�@  S TO DO: if makeKey not specified, throw error if all items are not same type (number/text/date); this'll prevent unpredictable results due to mixed types (e.g. {11,"2"} vs {"11", 2}), forcing users to pass an appropriate comparator if they want to sort mixed lists   T �UU   T O   D O :   i f   m a k e K e y   n o t   s p e c i f i e d ,   t h r o w   e r r o r   i f   a l l   i t e m s   a r e   n o t   s a m e   t y p e   ( n u m b e r / t e x t / d a t e ) ;   t h i s ' l l   p r e v e n t   u n p r e d i c t a b l e   r e s u l t s   d u e   t o   m i x e d   t y p e s   ( e . g .   { 1 1 , " 2 " }   v s   { " 1 1 " ,   2 } ) ,   f o r c i n g   u s e r s   t o   p a s s   a n   a p p r o p r i a t e   c o m p a r a t o r   i f   t h e y   w a n t   t o   s o r t   m i x e d   l i s t sR VWV Z   E �XY�?ZX F   E V[\[ >  E H]^] o   E F�>�> $0 comparatorobject comparatorObject^ m   F G�=
�= 
msng\ I   K T�<_�;�< 0 _hashandler _hasHandler_ `�:` N   L Paa n   L Obcb o   M O�9�9 0 makekey makeKeyc o   L M�8�8  0 sortcomparator sortComparator�:  �;  Y l  Y \defd r   Y \ghg o   Y Z�7�7  0 sortcomparator sortComparatorh o      �6�6 0 keymaker keyMakere M G call comparator's makeKey method to generate each sortable key in turn   f �ii �   c a l l   c o m p a r a t o r ' s   m a k e K e y   m e t h o d   t o   g e n e r a t e   e a c h   s o r t a b l e   k e y   i n   t u r n�?  Z k   _ �jj klk Z   _ �mn�5�4m F   _ �opo F   _ zqrq >   _ jsts l  _ fu�3�2u I  _ f�1vw
�1 .corecnte****       ****v o   _ `�0�0 0 
resultlist 
resultListw �/x�.
�/ 
koclx m   a b�-
�- 
nmbr�.  �3  �2  t n  f iyzy 1   g i�,
�, 
lengz o   f g�+�+ 0 
resultlist 
resultListr >   m x{|{ l 	 m t}�*�)} l  m t~�(�'~ I  m t�&�
�& .corecnte****       **** o   m n�%�% 0 
resultlist 
resultList� �$��#
�$ 
kocl� m   o p�"
�" 
ctxt�#  �(  �'  �*  �)  | n  t w��� 1   u w�!
�! 
leng� o   t u� �  0 
resultlist 
resultListp >   } ���� l 	 } ����� l  } ����� I  } ����
� .corecnte****       ****� o   } ~�� 0 
resultlist 
resultList� ���
� 
kocl� m    ��
� 
ldt �  �  �  �  �  � n  � ���� 1   � ��
� 
leng� o   � ��� 0 
resultlist 
resultListn R   � ����
� .ascrerr ****      � ****� m   � ��� ��� � O n l y   l i s t s   o f   n u m b e r s   O R   t e x t   O R   d a t e s   c a n   b e   s o r t e d   u n l e s s   t h e    u s i n g    p a r a m e t e r   i s   g i v e n .� ���
� 
errn� m   � ����Y�  �5  �4  l ��� r   � ���� I   � ����� 00 _makedefaultcomparator _makeDefaultComparator�  �  � o      �� 0 keymaker keyMaker�  W ��� l  � ����� r   � ���� J   � ��� ��� m   � ���  � ��
� m   � ��	�	  �
  � J      �� ��� o      ��  0 ascendingcount ascendingCount� ��� o      �� "0 descendingcount descendingCount�  � � � while generating keys also check if list is already almost/fully sorted (either ascending or descending) and if it is use insertionsort/return as-is   � ���*   w h i l e   g e n e r a t i n g   k e y s   a l s o   c h e c k   i f   l i s t   i s   a l r e a d y   a l m o s t / f u l l y   s o r t e d   ( e i t h e r   a s c e n d i n g   o r   d e s c e n d i n g )   a n d   i f   i t   i s   u s e   i n s e r t i o n s o r t / r e t u r n   a s - i s� ��� r   � ���� n   � ���� 2  � ��
� 
cobj� o   � ��� 0 
resultlist 
resultList� o      �� 0 keylist keyList� ��� Q   ������ k   �j�� ��� Q   � ����� r   � ���� n  � ���� I   � ����� 0 makekey makeKey� �� � n   � ���� 4   � ����
�� 
cobj� m   � ����� � o   � ����� 0 keylist keyList�   �  � o   � �����  0 sortcomparator sortComparator� o      ���� 0 previouskey previousKey� R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enum eNum� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  � R   � �����
�� .ascrerr ****      � ****� b   � ���� m   � ��� ��� : C o u l d n ' t   m a k e K e y   f o r   i t e m   1 :  � o   � ����� 0 etext eText� ����
�� 
errn� o   � ����� 0 enum eNum� ����
�� 
erob� o   � ����� 0 efrom eFrom� �����
�� 
errt� o   � ����� 
0 eto eTo��  � ��� r   � ���� o   � ����� 0 previouskey previousKey� n      ��� 4   � ����
�� 
cobj� m   � ����� � o   � ����� 0 keylist keyList� ���� Y   �j�������� l e���� k  e�� ��� Q  6���� r  ��� n ��� I  ������� 0 makekey makeKey� ���� n  ��� 4  	���
�� 
cobj� o  
���� 0 i  � o  	���� 0 keylist keyList��  ��  � o  ����  0 sortcomparator sortComparator� o      ���� 0 
currentkey 
currentKey� R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enum eNum� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  � R  6����
�� .ascrerr ****      � ****� b  *5��� b  *3��� b  */��� m  *-�� ��� 4 C o u l d n ' t   m a k e K e y   f o r   i t e m  � o  -.���� 0 i  � m  /2�� �    :  � o  34���� 0 etext eText� ��
�� 
errn o  ���� 0 enum eNum ��
�� 
erob o  "#���� 0 efrom eFrom ����
�� 
errt o  &'���� 
0 eto eTo��  �  r  7=	 o  78���� 0 
currentkey 
currentKey	 n      

 4  9<��
�� 
cobj o  :;���� 0 i   o  89���� 0 keylist keyList  r  >G n >E I  ?E������  0 compareobjects compareObjects  o  ?@���� 0 previouskey previousKey �� o  @A���� 0 
currentkey 
currentKey��  ��   o  >?����  0 sortcomparator sortComparator o      ���� 0 keycomparison keyComparison �� Z  He�� A  HK o  HI���� 0 keycomparison keyComparison m  IJ����   l NS r  NS !  [  NQ"#" o  NO����  0 ascendingcount ascendingCount# m  OP���� ! o      ����  0 ascendingcount ascendingCount   current key is larger    �$$ ,   c u r r e n t   k e y   i s   l a r g e r %&% ?  VY'(' o  VW���� 0 keycomparison keyComparison( m  WX����  & )��) l \a*+,* r  \a-.- [  \_/0/ o  \]���� "0 descendingcount descendingCount0 m  ]^���� . o      ���� "0 descendingcount descendingCount+   previous key is larger   , �11 .   p r e v i o u s   k e y   i s   l a r g e r��  ��  ��  � @ : TO DO: once again, need to know index for error reporting   � �22 t   T O   D O :   o n c e   a g a i n ,   n e e d   t o   k n o w   i n d e x   f o r   e r r o r   r e p o r t i n g�� 0 i  � m   � ����� � n  � �343 1   � ���
�� 
leng4 o   � ����� 0 keylist keyList��  ��  � R      ��56
�� .ascrerr ****      � ****5 o      ���� 0 etext eText6 ��78
�� 
errn7 o      ���� 0 enum eNum8 ��9��
�� 
errt9 o      ���� 
0 eto eTo��  � R  r���:;
�� .ascrerr ****      � ****: o  ������ 0 etext eText; ��<=
�� 
errn< o  vw���� 0 enum eNum= ��>?
�� 
erob> l z@����@ N  zAA n  z~BCB 4  {~��D
�� 
cobjD o  |}���� 0 i  C o  z{���� 0 
resultlist 
resultList��  ��  ? ��E��
�� 
errtE o  ������ 
0 eto eTo��  � FGF l ����HI��  H � �	log "   ORDEREDNESS=" & (ascendingCount * 100 div (resultList's length)) & " " & (descendingCount * 100 div (resultList's length))   I �JJ 	 l o g   "       O R D E R E D N E S S = "   &   ( a s c e n d i n g C o u n t   *   1 0 0   d i v   ( r e s u l t L i s t ' s   l e n g t h ) )   &   "   "   &   ( d e s c e n d i n g C o u n t   *   1 0 0   d i v   ( r e s u l t L i s t ' s   l e n g t h ) )G KLK l ����MN��  M � � TO DO: if list is almost or fully ordered then tell _sort() to use insertionsort or return as-is (remembering to reverse order as necessary), as that will be quicker than quicksorting the whole thing   N �OO�   T O   D O :   i f   l i s t   i s   a l m o s t   o r   f u l l y   o r d e r e d   t h e n   t e l l   _ s o r t ( )   t o   u s e   i n s e r t i o n s o r t   o r   r e t u r n   a s - i s   ( r e m e m b e r i n g   t o   r e v e r s e   o r d e r   a s   n e c e s s a r y ) ,   a s   t h a t   w i l l   b e   q u i c k e r   t h a n   q u i c k s o r t i n g   t h e   w h o l e   t h i n gL PQP l ����RS��  R TO DO: what about lists containing lots of duplicates, e.g. when sorting a large list containing only numbers from 0 to 10, or only true/false (basic quicksort gets pathological on those cases, so a three-way quicksort or a mergesort would work much better there)   S �TT   T O   D O :   w h a t   a b o u t   l i s t s   c o n t a i n i n g   l o t s   o f   d u p l i c a t e s ,   e . g .   w h e n   s o r t i n g   a   l a r g e   l i s t   c o n t a i n i n g   o n l y   n u m b e r s   f r o m   0   t o   1 0 ,   o r   o n l y   t r u e / f a l s e   ( b a s i c   q u i c k s o r t   g e t s   p a t h o l o g i c a l   o n   t h o s e   c a s e s ,   s o   a   t h r e e - w a y   q u i c k s o r t   o r   a   m e r g e s o r t   w o u l d   w o r k   m u c h   b e t t e r   t h e r e )Q UVU l ��WXYW r  ��Z[Z A  ��\]\ n ��^_^ 1  ����
�� 
leng_ o  ������ 0 
resultlist 
resultList] m  ������ 
[ o      ���� 0 usequicksort useQuickSortX   or is nearly ordered   Y �`` *   o r   i s   n e a r l y   o r d e r e dV aba I  ����c���� 	0 _sort  c ded o  ������ 0 keylist keyListe fgf o  ������ 0 
resultlist 
resultListg hih m  ������ i jkj n ��lml 1  ����
�� 
lengm o  ������ 0 
resultlist 
resultListk non o  ������  0 sortcomparator sortComparatoro p��p o  ������ 0 usequicksort useQuickSort��  ��  b q��q L  ��rr o  ������ 0 
resultlist 
resultList��   R      ��st
�� .ascrerr ****      � ****s o      ���� 0 etext eTextt ��uv
�� 
errnu o      ���� 0 enumber eNumberv ��wx
�� 
erobw o      �� 0 efrom eFromx �~y�}
�~ 
errty o      �|�| 
0 eto eTo�}   I  ���{z�z�{ 20 _errorwithpartialresult _errorWithPartialResultz {|{ m  ��}} �~~  s o r t   l i s t| � o  ���y�y 0 etext eText� ��� o  ���x�x 0 enumber eNumber� ��� o  ���w�w 0 efrom eFrom� ��� o  ���v�v 
0 eto eTo� ��u� o  ���t�t 0 
resultlist 
resultList�u  �z  �_   ��� l     �s�r�q�s  �r  �q  � ��� l     �p�o�n�p  �o  �n  � ��� i  A D��� I     �m�l�k
�m .Lst:DeSonull��� ��� null�l  �k  � h     �j��j &0 defaultcomparator DefaultComparator� k      �� ��� j     �i��i "0 _supportedtypes _supportedTypes� J     �� ��� m     �h
�h 
nmbr� ��� m    �g
�g 
ctxt� ��f� m    �e
�e 
ldt �f  � ��� j    	�d��d 	0 _type  � m    �c
�c 
msng� ��� i   
 ��� I      �b��a�b 0 makekey makeKey� ��`� o      �_�_ 0 anobject anObject�`  �a  � k     ��� ��� Z     �����^� =    ��� o     �]�] 	0 _type  � m    �\
�\ 
msng� k   
 J�� ��� X   
 A��[�� Z    <���Z�Y� I   )�X��
�X .corecnte****       ****� J    �� ��W� o    �V�V 0 anobject anObject�W  � �U��T
�U 
kocl� ?     %��� n    #��� 1   ! #�S
�S 
pcnt� o     !�R�R 0 aref aRef� m   # $�Q�Q  �T  � k   , 8�� ��� r   , 5��� n  , /��� 1   - /�P
�P 
pcnt� o   , -�O�O 0 aref aRef� o      �N�N 	0 _type  � ��M� L   6 8�� o   6 7�L�L 0 anobject anObject�M  �Z  �Y  �[ 0 aref aRef� n   ��� o    �K�K "0 _supportedtypes _supportedTypes�  f    � ��J� R   B J�I��
�I .ascrerr ****      � ****� m   H I�� ��� � I n v a l i d   i t e m   t y p e   ( d e f a u l t   c o m p a r a t o r   c a n   o n l y   c o m p a r e   i n t e g e r / r e a l ,   t e x t ,   o r   d a t e   t y p e s ) .� �H��
�H 
errn� m   D E�G�G�\� �F��E
�F 
erob� o   F G�D�D 0 anobject anObject�E  �J  � ��� I  M \�C��
�C .corecnte****       ****� J   M P�� ��B� o   M N�A�A 0 anobject anObject�B  � �@��?
�@ 
kocl� =   Q X��� o   Q V�>�> 	0 _type  � m   V W�=�=  �?  � ��<� k   _ ��� ��� Z   _ x���;�� I  _ l�:��
�: .corecnte****       ****� J   _ b�� ��9� o   _ `�8�8 0 anobject anObject�9  � �7��6
�7 
kocl� ?   c h��� l  c f��5�4� n  c f��� o   d f�3�3 "0 _supportedtypes _supportedTypes�  f   c d�5  �4  � m   f g�2�2  �6  � r   o r��� m   o p�� ��� d d e f a u l t   c o m p a r a t o r   c a n n o t   c o m p a r e   m i x e d   i t e m   t y p e s� o      �1�1 0 etext eText�;  � r   u x��� m   u v�� ��� � d e f a u l t   c o m p a r a t o r   c a n   o n l y   c o m p a r e   i n t e g e r / r e a l ,   t e x t ,   o r   d a t e   t y p e s� o      �0�0 0 etext eText� ��/� R   y ��.��
�. .ascrerr ****      � ****� b   � ���� b   � ���� m   � ��� ��� & I n v a l i d   i t e m   t y p e   (� o   � ��-�- 0 etext eText� m   � ��� ���  ) .� �,��
�, 
errn� m   { |�+�+�\� �*��
�* 
erob� o   } ~�)�) 0 anobject anObject� �(	 �'
�( 
errt	  o    ��&�& 	0 _type  �'  �/  �<  �^  � 	�%	 L   � �		 o   � ��$�$ 0 anobject anObject�%  � 	�#	 i   			 I      �"	�!�"  0 compareobjects compareObjects	 			 o      � �  0 
leftobject 
leftObject	 		�		 o      �� 0 rightobject rightObject�  �!  	 Z     	
				
 A     			 o     �� 0 
leftobject 
leftObject	 o    �� 0 rightobject rightObject	 L    		 m    ����	 			 ?    			 o    �� 0 
leftobject 
leftObject	 o    �� 0 rightobject rightObject	 	�	 L    		 m    �� �  	 L    		 m    ��  �#  � 			 l     ����  �  �  	 			 l     ����  �  �  	 			 i  E H			 I     ���
� .Lst:NuSonull��� ��� null�  �  	 h     �	 � &0 numericcomparator NumericComparator	  k      	!	! 	"	#	" i    	$	%	$ I      �	&�
� 0 makekey makeKey	& 	'�		' o      �� 0 anobject anObject�	  �
  	% L     	(	( c     	)	*	) o     �� 0 anobject anObject	* m    �
� 
nmbr	# 	+�	+ i   	,	-	, I      �	.��  0 compareobjects compareObjects	. 	/	0	/ o      �� 0 
leftobject 
leftObject	0 	1�	1 o      � �  0 rightobject rightObject�  �  	- l    	2	3	4	2 L     	5	5 \     	6	7	6 o     ���� 0 
leftobject 
leftObject	7 o    ���� 0 rightobject rightObject	3 � � note: since compareObjects' return value can be any -ve/0/+ve number, a single subtraction operation is sufficient for numbers and dates   	4 �	8	8   n o t e :   s i n c e   c o m p a r e O b j e c t s '   r e t u r n   v a l u e   c a n   b e   a n y   - v e / 0 / + v e   n u m b e r ,   a   s i n g l e   s u b t r a c t i o n   o p e r a t i o n   i s   s u f f i c i e n t   f o r   n u m b e r s   a n d   d a t e s�  	 	9	:	9 l     ��������  ��  ��  	: 	;	<	; l     ��������  ��  ��  	< 	=	>	= i  I L	?	@	? I     ������
�� .Lst:DaSonull��� ��� null��  ��  	@ h     ��	A��  0 datecomparator DateComparator	A k      	B	B 	C	D	C i    	E	F	E I      ��	G���� 0 makekey makeKey	G 	H��	H o      ���� 0 anobject anObject��  ��  	F l    	I	J	K	I L     	L	L c     	M	N	M o     ���� 0 anobject anObject	N m    ��
�� 
ldt 	J�� TO DO: if coercion fails, try `date anObject` on offchance it's a text value? Am inclined not to, as that's locale dependent so will produce different results on different machines for same input (while text-to-number coercions are also a bit locale-sensitive, those coercions will simply fail whereas `date "05-05-05"` could produce multiple different values or errors). Safest approach is for user to supply her own comparator implementation that implements her exact requirements, rather than trying to second-guess what those requirements are (which has a tendency to create fresh problems faster than it solves them, as AppleScript frequently demonstrates).   	K �	O	O.   T O   D O :   i f   c o e r c i o n   f a i l s ,   t r y   ` d a t e   a n O b j e c t `   o n   o f f c h a n c e   i t ' s   a   t e x t   v a l u e ?   A m   i n c l i n e d   n o t   t o ,   a s   t h a t ' s   l o c a l e   d e p e n d e n t   s o   w i l l   p r o d u c e   d i f f e r e n t   r e s u l t s   o n   d i f f e r e n t   m a c h i n e s   f o r   s a m e   i n p u t   ( w h i l e   t e x t - t o - n u m b e r   c o e r c i o n s   a r e   a l s o   a   b i t   l o c a l e - s e n s i t i v e ,   t h o s e   c o e r c i o n s   w i l l   s i m p l y   f a i l   w h e r e a s   ` d a t e   " 0 5 - 0 5 - 0 5 " `   c o u l d   p r o d u c e   m u l t i p l e   d i f f e r e n t   v a l u e s   o r   e r r o r s ) .   S a f e s t   a p p r o a c h   i s   f o r   u s e r   t o   s u p p l y   h e r   o w n   c o m p a r a t o r   i m p l e m e n t a t i o n   t h a t   i m p l e m e n t s   h e r   e x a c t   r e q u i r e m e n t s ,   r a t h e r   t h a n   t r y i n g   t o   s e c o n d - g u e s s   w h a t   t h o s e   r e q u i r e m e n t s   a r e   ( w h i c h   h a s   a   t e n d e n c y   t o   c r e a t e   f r e s h   p r o b l e m s   f a s t e r   t h a n   i t   s o l v e s   t h e m ,   a s   A p p l e S c r i p t   f r e q u e n t l y   d e m o n s t r a t e s ) .	D 	P��	P i   	Q	R	Q I      ��	S����  0 compareobjects compareObjects	S 	T	U	T o      ���� 0 
leftobject 
leftObject	U 	V��	V o      ���� 0 rightobject rightObject��  ��  	R l    	W	X	Y	W L     	Z	Z \     	[	\	[ o     ���� 0 
leftobject 
leftObject	\ o    ���� 0 rightobject rightObject	X Y S as in NumericComparator, a simple subtraction operation produces a suitable result   	Y �	]	] �   a s   i n   N u m e r i c C o m p a r a t o r ,   a   s i m p l e   s u b t r a c t i o n   o p e r a t i o n   p r o d u c e s   a   s u i t a b l e   r e s u l t��  	> 	^	_	^ l     ��������  ��  ��  	_ 	`	a	` l     ��������  ��  ��  	a 	b	c	b i  M P	d	e	d I     ����	f
�� .Lst:TeSonull��� ��� null��  	f ��	g��
�� 
Cons	g |����	h��	i��  ��  	h o      ����  0 orderingoption orderingOption��  	i m      ��
�� SrtECmpI��  	e Q     b	j	k	l	j k    L	m	m 	n	o	n h    
��	p�� B0 currentconsiderationscomparator CurrentConsiderationsComparator	p k      	q	q 	r	s	r i    	t	u	t I      ��	v���� 0 makekey makeKey	v 	w��	w o      ���� 0 anobject anObject��  ��  	u l    	x	y	z	x L     	{	{ c     	|	}	| o     ���� 0 anobject anObject	} m    ��
�� 
ctxt	y _ Y TO DO: what if item is a list [of text]? currently it coerces to text using current TIDs   	z �	~	~ �   T O   D O :   w h a t   i f   i t e m   i s   a   l i s t   [ o f   t e x t ] ?   c u r r e n t l y   i t   c o e r c e s   t o   t e x t   u s i n g   c u r r e n t   T I D s	s 	��	 i   	�	�	� I      ��	�����  0 compareobjects compareObjects	� 	�	�	� o      ���� 0 
leftobject 
leftObject	� 	���	� o      ���� 0 rightobject rightObject��  ��  	� k     '	�	� 	�	�	� I    ��	���
�� .ascrcmnt****      � ****	� J     
	�	� 	�	�	� o     ���� 0 
leftobject 
leftObject	� 	�	�	� o    ���� 0 rightobject rightObject	� 	�	�	� A    	�	�	� o    ���� 0 
leftobject 
leftObject	� o    ���� 0 rightobject rightObject	� 	���	� ?    	�	�	� o    ���� 0 
leftobject 
leftObject	� o    ���� 0 rightobject rightObject��  ��  	� 	���	� Z    '	�	�	�	�	� A    	�	�	� o    ���� 0 
leftobject 
leftObject	� o    ���� 0 rightobject rightObject	� L    	�	� m    ������	� 	�	�	� ?    	�	�	� o    ���� 0 
leftobject 
leftObject	� o    ���� 0 rightobject rightObject	� 	���	� L     "	�	� m     !���� ��  	� L   % '	�	� m   % &����  ��  ��  	o 	���	� Z    L	�	�	�	�	� =   	�	�	� o    ����  0 orderingoption orderingOption	� m    ��
�� SrtECmpI	� k    	�	� 	�	�	� h    ��	��� >0 caseinsensitivetextcomparator CaseInsensitiveTextComparator	� k      	�	� 	�	�	� j     ��	�
�� 
pare	� o     ���� B0 currentconsiderationscomparator CurrentConsiderationsComparator	� 	���	� i  	 	�	�	� I      ��	�����  0 compareobjects compareObjects	� 	�	�	� o      ���� 0 
leftobject 
leftObject	� 	���	� o      ���� 0 rightobject rightObject��  ��  	� P     	�	�	�	� L    	�	� M    	�	� I      ��	�����  0 compareobjects compareObjects	� 	�	�	� o    ���� 0 
leftobject 
leftObject	� 	���	� o    ���� 0 rightobject rightObject��  ��  	� ��	�
�� conshyph	� ��	�
�� conspunc	� ��	�
�� conswhit	� ����
�� consnume��  	� ��	�
�� conscase	� ����
�� consdiac��  ��  	� 	���	� L    	�	� o    ���� >0 caseinsensitivetextcomparator CaseInsensitiveTextComparator��  	� 	�	�	� =   !	�	�	� o    ����  0 orderingoption orderingOption	� m     ��
�� SrtECmpC	� 	�	�	� k   $ .	�	� 	�	�	� h   $ +��	��� :0 casesensitivetextcomparator CaseSensitiveTextComparator	� k      	�	� 	�	�	� j     ��	�
�� 
pare	� o     ���� B0 currentconsiderationscomparator CurrentConsiderationsComparator	� 	���	� i  	 	�	�	� I      ��	�����  0 compareobjects compareObjects	� 	�	�	� o      ���� 0 
leftobject 
leftObject	� 	���	� o      ���� 0 rightobject rightObject��  ��  	� P     	�	�	�	� L    	�	� M    	�	� I      ��	�����  0 compareobjects compareObjects	� 	�	�	� o    ���� 0 
leftobject 
leftObject	� 	���	� o    ���� 0 rightobject rightObject��  ��  	� ��	�
�� conscase	� ��	�
�� conshyph	� ��	�
�� conspunc	� ��	�
�� conswhit	� ����
�� consnume��  	� ����
�� consdiac��  ��  	� 	���	� L   , .	�	� o   , -���� :0 casesensitivetextcomparator CaseSensitiveTextComparator��  	� 	�	�	� =  1 4	�	�	� o   1 2����  0 orderingoption orderingOption	� m   2 3��
�� SrtECmpD	� 	���	� L   7 9	�	� o   7 8�� B0 currentconsiderationscomparator CurrentConsiderationsComparator��  	� R   < L�~	�	�
�~ .ascrerr ****      � ****	� m   H K	�	� �	�	� d I n v a l i d    f o r    p a r a m e t e r   ( n o t   a n   a l l o w e d   c o n s t a n t ) .	� �}	�	�
�} 
errn	� m   > ?�|�|�Y	� �{	�	�
�{ 
erob	� o   @ A�z�z  0 orderingoption orderingOption	� �y	��x
�y 
errt	� m   B E�w
�w 
enum�x  ��  	k R      �v	�	�
�v .ascrerr ****      � ****	� o      �u�u 0 etext eText	� �t	�
 
�t 
errn	� o      �s�s 0 enumber eNumber
  �r


�r 
erob
 o      �q�q 0 efrom eFrom
 �p
�o
�p 
errt
 o      �n�n 
0 eto eTo�o  	l I   T b�m
�l�m 
0 _error  
 


 m   U X

 �

  t e x t   c o m p a r a t o r
 
	


	 o   X Y�k�k 0 etext eText

 


 o   Y Z�j�j 0 enumber eNumber
 


 o   Z [�i�i 0 efrom eFrom
 
�h
 o   [ \�g�g 
0 eto eTo�h  �l  	c 


 l     �f�e�d�f  �e  �d  
 


 l     �c�b�a�c  �b  �a  
 


 l     �`�_�^�`  �_  �^  
 


 i   Q T


 I     �]
�\
�] .Lst:LiUSnull���     ****
 o      �[�[ 0 thelist theList�\  
 Q     



 k    m

 

 
 r    
!
"
! n    
#
$
# 2   �Z
�Z 
cobj
$ n   
%
&
% I    �Y
'�X�Y "0 aslistparameter asListParameter
' 
(
)
( o    	�W�W 0 thelist theList
) 
*�V
* m   	 

+
+ �
,
,  �V  �X  
& o    �U�U 0 _supportlib _supportLib
" o      �T�T 0 
resultlist 
resultList
  
-
.
- r    
/
0
/ n    
1
2
1 1    �S
�S 
leng
2 o    �R�R 0 
resultlist 
resultList
0 o      �Q�Q 0 len  
. 
3
4
3 l   �P
5
6�P  
5 � � call `random number` osax once to obtain a seed, then switch to native pseudo-random number generation for generating 'random' list indexes; this should provide modest improvement in speed   
6 �
7
7z   c a l l   ` r a n d o m   n u m b e r `   o s a x   o n c e   t o   o b t a i n   a   s e e d ,   t h e n   s w i t c h   t o   n a t i v e   p s e u d o - r a n d o m   n u m b e r   g e n e r a t i o n   f o r   g e n e r a t i n g   ' r a n d o m '   l i s t   i n d e x e s ;   t h i s   s h o u l d   p r o v i d e   m o d e s t   i m p r o v e m e n t   i n   s p e e d
4 
8
9
8 r    )
:
;
: I   '
<�O
=
< z�N�M
�N .sysorandnmbr    ��� nmbr
�M misccura�O  
= �L
>
?
�L 
from
> m     �K�K 
? �J
@�I
�J 
to  
@ m   ! "
A
A B�0��?� �I  
; o      �H�H 0 lastnum lastNum
9 
B
C
B Y   * j
D�G
E
F�F
D k   4 e
G
G 
H
I
H r   4 ;
J
K
J `   4 9
L
M
L l  4 7
N�E�D
N ]   4 7
O
P
O o   4 5�C�C 0 lastnum lastNum
P m   5 6�B�B  J��E  �D  
M m   7 8
Q
Q B�0��?� 
K o      �A�A 0 lastnum lastNum
I 
R
S
R r   < C
T
U
T [   < A
V
W
V l  < ?
X�@�?
X `   < ?
Y
Z
Y o   < =�>�> 0 lastnum lastNum
Z o   = >�=�= 0 len  �@  �?  
W m   ? @�<�< 
U o      �;�; 0 idx2  
S 
[�:
[ r   D e
\
]
\ J   D P
^
^ 
_
`
_ e   D I
a
a n  D I
b
c
b 4   E H�9
d
�9 
cobj
d o   F G�8�8 0 idx2  
c o   D E�7�7 0 
resultlist 
resultList
` 
e�6
e e   I N
f
f n  I N
g
h
g 4   J M�5
i
�5 
cobj
i o   K L�4�4 0 idx1  
h o   I J�3�3 0 
resultlist 
resultList�6  
] J      
j
j 
k
l
k n     
m
n
m 4   V Y�2
o
�2 
cobj
o o   W X�1�1 0 idx1  
n o   U V�0�0 0 
resultlist 
resultList
l 
p�/
p n     
q
r
q 4   ` c�.
s
�. 
cobj
s o   a b�-�- 0 idx2  
r o   _ `�,�, 0 
resultlist 
resultList�/  �:  �G 0 idx1  
E m   - .�+�+ 
F o   . /�*�* 0 len  �F  
C 
t�)
t L   k m
u
u o   k l�(�( 0 
resultlist 
resultList�)  
 R      �'
v
w
�' .ascrerr ****      � ****
v o      �&�& 0 etext eText
w �%
x
y
�% 
errn
x o      �$�$ 0 enumber eNumber
y �#
z
{
�# 
erob
z o      �"�" 0 efrom eFrom
{ �!
|� 
�! 
errt
| o      �� 
0 eto eTo�   
 I   u �
}�� 
0 _error  
} 
~

~ m   v w
�
� �
�
�  u n s o r t   l i s t
 
�
�
� o   w x�� 0 etext eText
� 
�
�
� o   x y�� 0 enumber eNumber
� 
�
�
� o   y z�� 0 efrom eFrom
� 
��
� o   z {�� 
0 eto eTo�  �  
 
�
�
� l     ����  �  �  
� 
��
� l     ����  �  �  �       �
�
�
�
�
�
�
�
�
�
�
�
�
�
�
�
�
�
�
�
��  
� ������
�	��������� ������
� 
pimr� 0 _supportlib _supportLib� 
0 _error  � 20 _errorwithpartialresult _errorWithPartialResult� "0 _makelistobject _makeListObject
�
 .Lst:Instnull���     ****
�	 .Lst:Delenull���     ****
� .Lst:Trannull���     ****
� .Lst:Map_null���     ****
� .Lst:Filtnull���     ****
� .Lst:Redunull���     ****� 0 _hashandler _hasHandler� 	0 _sort  
� .Lst:Sortnull���     ****
� .Lst:DeSonull��� ��� null
�  .Lst:NuSonull��� ��� null
�� .Lst:DaSonull��� ��� null
�� .Lst:TeSonull��� ��� null
�� .Lst:LiUSnull���     ****
� ��
��� 
�  
�
� ��
���
�� 
cobj
� 
�
�   ��
�� 
osax��  
� 
�
�   �� %
�� 
scpt
� �� -����
�
����� 
0 _error  �� ��
��� 
�  ������������ 0 handlername handlerName�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo��  
� ������������ 0 handlername handlerName�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo
� ������
�� 
msng�� �� 20 _errorwithpartialresult _errorWithPartialResult�� *�������+ 
� �� I����
�
����� 20 _errorwithpartialresult _errorWithPartialResult�� ��
��� 
�  �������������� 0 handlername handlerName�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo�� 0 partialresult partialResult��  
� �������������� 0 handlername handlerName�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo�� 0 partialresult partialResult
�  [������
�� 
msng�� �� 0 rethrowerror rethrowError�� b  ࠡ�����+ 
� �� z����
�
����� "0 _makelistobject _makeListObject�� ��
��� 
�  ������ 0 len  �� 0 padvalue padValue��  
� �������� 0 len  �� 0 padvalue padValue�� 0 
listobject 
ListObject
� �� �
����������� 0 
listobject 
ListObject
� ��
�����
�
���
�� .ascrinit****      � ****
� k     
�
�  �����  ��  ��  
� ���� 0 _  
� ���� 0 _  �� jv��� �� 0 _  
�� 
leng
�� 
cobj�� `��K S�O�j L�����v��,FO h��,�,���,��,%��,F[OY��O��,�,� ��,[�\[Zk\Z�2��,FY hY hO��,E
� �� �����
�
���
�� .Lst:Instnull���     ****�� 0 thelist theList�� ����
�
�� 
Valu�� 0 thevalue theValue
� ��
�
�
�� 
Befo
� {�������� 0 beforeindex beforeIndex��  
�� 
msng
� ��
���
�� 
Afte
� {�������� 0 
afterindex 
afterIndex��  
�� 
msng��  
� ������������������ 0 thelist theList�� 0 thevalue theValue�� 0 beforeindex beforeIndex�� 0 
afterindex 
afterIndex�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo
� ��������!��������������<Xw������
�������� "0 aslistparameter asListParameter
�� 
msng
�� 
errn���Y�� (0 asintegerparameter asIntegerParameter
�� 
leng���@
�� 
erob
�� 
cobj
�� 
insl�� 
�� 
bool�� 0 etext eText
� ����
�
�� 
errn�� 0 enumber eNumber
� ����
�
�� 
erob�� 0 efrom eFrom
� ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  ��1b  ��l+ E�O�� R�� )��l�Y hOb  ��l+ E�O�j ��,�kE�Y hO���, )����/�4��Y hY v�� hb  ��l+ E�O�j 
�kE�Y "�j ��,�E�Y )����/�3�a O���,
 	�ja & )����/�3�a Y hY 
)��la O�j  �kv�%Y 1���,  ��kv%Y  �[�\[Zk\Z�2�kv%�[�\[Z�k\Zi2%W X  *a ����a + 
� �������
�
���
�� .Lst:Delenull���     ****�� 0 thelist theList�� ��
���
�� 
Inde
� {�������� 0 theindex theIndex��  ������  
� �������������� 0 thelist theList�� 0 theindex theIndex�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo
� ��
�~�}�|�{�z�y�x�w�v}�u
���t�s� "0 aslistparameter asListParameter�~ (0 asintegerparameter asIntegerParameter
�} 
leng
�| 
bool
�{ 
cobj
�z 
rest
�y 
errn�x�@
�w 
erob�v �u 0 etext eText
� �r�q
�
�r 
errn�q 0 enumber eNumber
� �p�o
�
�p 
erob�o 0 efrom eFrom
� �n�m�l
�n 
errt�m 
0 eto eTo�l  �t �s 
0 _error  �� � �b  ��l+ E�Ob  ��l+ E�O��,k	 �j�& {i��,lv�kv �[�\[Zl\Zi2EY [k��,'lv�kv 
��,EY E�j	 	���,�&
 �j	 
���,'�&�& !�[�\[Zk\Z�k2�[�\[Z�k\Zi2%Y hY  ��,k  iklv�kv jvY hY hO)����/��W X  *��a + 
� �k��j�i
�
��h
�k .Lst:Trannull���     ****�j 0 thelist theList�i �g
�
�
�g 
Whil
� {�f�e�d�f 0 unevenoption unevenOption�e  
�d LTrhLTrR
� �c
��b
�c 
PadI
� {�a�`�_�a 0 padvalue padValue�`  
�_ 
msng�b  
� �^�]�\�[�Z�Y�X�W�V�U�T�S�R�Q�^ 0 thelist theList�] 0 unevenoption unevenOption�\ 0 padvalue padValue�[ 0 
listobject 
ListObject�Z $0 resultlistlength resultListLength�Y 0 aref aRef�X (0 emptyresultsublist emptyResultSubList�W $0 resultlistobject ResultListObject�V 0 i  �U 0 j  �T 0 etext eText�S 0 enumber eNumber�R 0 efrom eFrom�Q 
0 eto eTo
�  �P�O�N�M�L�K�J�I��H�
��G�F�E�D��C�B�A�@�?+�>�=E
��<
���;�:
�P 
kocl
�O 
list
�N .corecnte****       ****
�M 
bool
�L 
errn�K�Y
�J 
erob�I �H 0 
listobject 
ListObject
� �9
��8�7
�
��6
�9 .ascrinit****      � ****
� k     
�
� ��5�5  �8  �7  
� �4�4 0 _  
� �3�3 0 _  �6 b   ��G 0 _  
�F 
cobj
�E 
leng
�D LTrhLTrR
�C LTrhLTrP
�B LTrhLTrT
�A 
errt
�@ 
enum�? �> "0 _makelistobject _makeListObject�= $0 resultlistobject ResultListObject
� �2
��1�0
�
��/
�2 .ascrinit****      � ****
� k     
�
� E�.�.  �1  �0  
� �-�- 0 _  
� �,�, 0 _  �/ jv��< 0 etext eText
� �+�*
�
�+ 
errn�* 0 enumber eNumber
� �)�(
�
�) 
erob�( 0 efrom eFrom
� �'�&�%
�' 
errt�& 
0 eto eTo�%  �; �: 
0 _error  �h���jv  jvY hO�kv��l j 
 ���l �j �& )�����Y hO��K S�O��,�k/�,E�O��  2 ,��,[��l kh ��,� )����a Y h[OY��Y z�a   - '��,[��l kh ��,� 
��,E�Y h[OY��Y G�a   - '��,[��l kh ��,� 
��,E�Y h[OY��Y )���a a a a O*��,�,�l+ E�Oa a K S�O k�kkh ��-E��,6F[OY��O���,6FO =k��,�,Ekh  )k��,��/�,Ekh 	��,��/��/��,��/��/F[OY��[OY��O��,EW X  *a ����a + 
� �$��#�"
�
��!
�$ .Lst:Map_null���     ****�# 0 thelist theList�" � ��
�  
Usin� 0 	thescript 	theScript�  
� ��������� 0 thelist theList� 0 	thescript 	theScript� 0 
resultlist 
resultList� 0 i  � 0 etext eText� 0 enumber eNumber� 
0 eto eTo� 0 efrom eFrom
� ��������
�����!#
�;�� "0 aslistparameter asListParameter� &0 asscriptparameter asScriptParameter
� 
leng
� 
cobj� 0 convertitem convertItem� 0 etext eText
� �
�	
�
�
 
errn�	 0 enumber eNumber
� ���
� 
errt� 
0 eto eTo�  
� 
errn
� 
erob
� 
errt� 
� ��
�
� 
errn� 0 enumber eNumber
� ��
�
� 
erob� 0 efrom eFrom
� �� ��
� 
errt�  
0 eto eTo��  � 20 _errorwithpartialresult _errorWithPartialResult�! zjvE�O ab  ��l+ E�Ob  ��l+ E�O # k��,Ekh ���/k+ �6F[OY��W X  )���/����%�%�%O�W X  *a ������+ 
� ��M����
�
���
�� .Lst:Filtnull���     ****�� 0 thelist theList�� ������
�� 
Usin�� 0 	thescript 	theScript��  
� ������������������ 0 thelist theList�� 0 	thescript 	theScript�� 0 
resultlist 
resultList�� 0 i  �� 0 etext eText�� 0 enumber eNumber�� 
0 eto eTo�� 0 efrom eFrom
� e��q����������
�����������
������ "0 aslistparameter asListParameter�� &0 asscriptparameter asScriptParameter
�� 
leng
�� 
cobj�� 0 	checkitem 	checkItem�� 0 etext eText
� ����
�
�� 
errn�� 0 enumber eNumber
� ������
�� 
errt�� 
0 eto eTo��  
�� 
errn
�� 
erob
�� 
errt�� 
� ����
�
�� 
errn�� 0 enumber eNumber
� ����
�
�� 
erob�� 0 efrom eFrom
� ������
�� 
errt�� 
0 eto eTo��  �� 20 _errorwithpartialresult _errorWithPartialResult�� zjvE�O ab  ��l+ E�Ob  ��l+ E�O # k��,Ekh ���/k+ �6F[OY��W X  )���/����%�%�%O�W X  *a ������+ 
� �������
�
���
�� .Lst:Redunull���     ****�� 0 thelist theList�� ������
�� 
Usin�� 0 	thescript 	theScript��  
� 	�������������������� 0 thelist theList�� 0 	thescript 	theScript�� 0 missingvalue missingValue�� 0 	theresult 	theResult�� 0 i  �� 0 etext eText�� 0 enumber eNumber�� 
0 eto eTo�� 0 efrom eFrom
� �����������������������
�����!
�9���� "0 aslistparameter asListParameter
�� 
leng
�� 
errn���Y
�� 
erob�� �� &0 asscriptparameter asScriptParameter
�� 
cobj�� 0 combineitems combineItems�� 0 etext eText
� ����
�
�� 
errn�� 0 enumber eNumber
� ������
�� 
errt�� 
0 eto eTo��  
�� 
errt�� 
� ����
�
�� 
errn�� 0 enumber eNumber
� ����
�
�� 
erob�� 0 efrom eFrom
� ������
�� 
errt�� 
0 eto eTo��  �� 20 _errorwithpartialresult _errorWithPartialResult�� ��E�O �b  ��l+ E�O��,j  )�����Y hOb  ��l+ 	E�O��k/E�O # l��,Ekh ����/l+ E�[OY��W X  )���/��a �%a %�%O�W X  *a ������+ 
� ��`����
�
����� 0 _hashandler _hasHandler�� ��
��� 
�  ���� 0 
handlerref 
handlerRef��  
� ���� 0 
handlerref 
handlerRef
� ����
�
�� 
hand��  
� ������
�� 
errn���\��  ��  ��&OeW 	X  f
� �������
�
����� 	0 _sort  �� ��
��� 
�  �������������� 0 keylist keyList�� 0 	valuelist 	valueList�� 0 	fromindex 	fromIndex�� 0 toindex toIndex��  0 sortcomparator sortComparator�� 0 usequicksort useQuickSort��  
� ������������������������������������ 0 keylist keyList�� 0 	valuelist 	valueList�� 0 	fromindex 	fromIndex�� 0 toindex toIndex��  0 sortcomparator sortComparator�� 0 usequicksort useQuickSort�� 0 	leftindex 	leftIndex�� 0 
rightindex 
rightIndex�� 0 
pivotvalue 
pivotValue�� 0 etext eText�� 0 enum eNum�� 0 efrom eFrom�� 
0 eto eTo�� 0 i  �� 0 j  �� 0 leftkey leftKey�� 0 rightkey rightKey
� ��������
������������~�}
�
�� 
cobj��  0 compareobjects compareObjects
�� 
nmbr�� 0 etext eText
� �|�{
�
�| 
errn�{ 0 enum eNum
� �z�y
�
�z 
erob�y 0 efrom eFrom
� �x�w�v
�x 
errt�w 
0 eto eTo�v  
�� 
errn
�� 
erob
�� 
errt�� � 
�~ 	0 _sort  �}  
� �u�t�s
�u 
errn�t�n�s  ��٥=��lvE[�k/E�Z[�l/E�ZO��.E�O �h�� " h���/�l+ �&j�kE�[OY��W X  )���/�lv���%O " h���/�l+ �&j�kE�[OY��W X  )���/�lv���%O�� f� !*�/*�/lvE[�k/*�/FZ[�l/*�/FZUO� !*�/*�/lvE[�k/*�/FZ[�l/*�/FZUO�k�klvE[�k/E�Z[�l/E�ZY h[OY�O '*���������+ O*���������+ OhW X  hY hO�kE�O ���kh  ���ih ��k/��/lvE[�k/E�Z[�l/E^ ZO��] l+ k Y hO] �lvE[�k/��k/FZ[�l/��/FZO��/��k/lvE[�k/��k/FZ[�l/��/FZ[OY��[OY�x
� �r�q�p
�
��o
�r .Lst:Sortnull���     ****�q 0 thelist theList�p �n
��m
�n 
Comp
� {�l�k�j�l $0 comparatorobject comparatorObject�k  
�j 
msng�m  
� �i�h�g�f�e�d�c�b�a�`�_�^�]�\�[�Z�Y�X�i 0 thelist theList�h $0 comparatorobject comparatorObject�g 0 
resultlist 
resultList�f  0 sortcomparator sortComparator�e 0 keymaker keyMaker�d  0 ascendingcount ascendingCount�c "0 descendingcount descendingCount�b 0 keylist keyList�a 0 previouskey previousKey�` 0 etext eText�_ 0 enum eNum�^ 0 efrom eFrom�] 
0 eto eTo�\ 0 i  �[ 0 
currentkey 
currentKey�Z 0 keycomparison keyComparison�Y 0 usequicksort useQuickSort�X 0 enumber eNumber
� ",�W�V�U�T�SH�R�Q�P�O�N�M�L�K�J�I�H��G
��F�E�D����C
��B�A
�}�@�W "0 aslistparameter asListParameter
�V 
cobj
�U 
leng
�T 
msng�S 00 _makedefaultcomparator _makeDefaultComparator�R &0 asscriptparameter asScriptParameter�Q 0 makekey makeKey�P 0 _hashandler _hasHandler
�O 
bool
�N 
kocl
�M 
nmbr
�L .corecnte****       ****
�K 
ctxt
�J 
ldt 
�I 
errn�H�Y�G 0 etext eText
� �?�>
�
�? 
errn�> 0 enum eNum
� �=�<
�
�= 
erob�< 0 efrom eFrom
� �;�:�9
�; 
errt�: 
0 eto eTo�9  
�F 
erob
�E 
errt�D �C  0 compareobjects compareObjects
� �8�7
�
�8 
errn�7 0 enum eNum
� �6�5�4
�6 
errt�5 
0 eto eTo�4  �B 
�A 	0 _sort  
� �3�2
�
�3 
errn�2 0 enumber eNumber
� �1�0
�
�1 
erob�0 0 efrom eFrom
� �/�.�-
�/ 
errt�. 
0 eto eTo�-  �@ 20 _errorwithpartialresult _errorWithPartialResult�o�jvE�O�b  ��l+ �-E�O��,l �Y hO��  *j+ E�Y b  ��l+ E�O��	 *��,k+ 	�& �E�Y H���l ��,	 ���l ��,�&	 ���l ��,�& )a a la Y hO*j+ E�OjjlvE[�k/E�Z[�l/E�ZO��-E�O � ���k/k+ E�W X  )a �a �a �a a �%O���k/FO rl��,Ekh  ���/k+ E�W #X  )a �a �a �a a �%a %�%O���/FO���l+ E�O�j 
�kE�Y �j 
�kE�Y h[OY��W X  )a �a ��/a �a �O��,a E^ O*��k��,�] a + O�W X  *a  �] ���a + !
� �,��+�*
� �)
�, .Lst:DeSonull��� ��� null�+  �*  
� �(�( &0 defaultcomparator DefaultComparator  �'��' &0 defaultcomparator DefaultComparator �&�%�$�#
�& .ascrinit****      � **** k      � � � 	�"�"  �%  �$   �!� ���! "0 _supportedtypes _supportedTypes�  	0 _type  � 0 makekey makeKey�  0 compareobjects compareObjects ������	

� 
nmbr
� 
ctxt
� 
ldt � "0 _supportedtypes _supportedTypes
� 
msng� 	0 _type  	 ������ 0 makekey makeKey� ��   �� 0 anobject anObject�   ���� 0 anobject anObject� 0 aref aRef� 0 etext eText �����
�	�����������
� 
msng� "0 _supportedtypes _supportedTypes
� 
kocl
� 
cobj
�
 .corecnte****       ****
�	 
pcnt
� 
errn��\
� 
erob� 
� 
errt� � �b  �  E 6)�,[��l kh �kv��,jl  ��,Ec  O�Y h[OY��O)�����Y F�kv�b  j l  3�kv�)�,jl  �E�Y �E�O)����b  ��%a %Y hO�
 �	�� ���  0 compareobjects compareObjects� ����   ������ 0 
leftobject 
leftObject�� 0 rightobject rightObject�    ������ 0 
leftobject 
leftObject�� 0 rightobject rightObject  �� �� iY �� kY j�# ���mv�O�OL OL �) ��K S�
� ��	������
�� .Lst:NuSonull��� ��� null��  ��   ���� &0 numericcomparator NumericComparator ��	 �� &0 numericcomparator NumericComparator ��������
�� .ascrinit****      � **** k      	" 	+����  ��  ��   ������ 0 makekey makeKey��  0 compareobjects compareObjects  ��	%�������� 0 makekey makeKey�� ����   ���� 0 anobject anObject��   ���� 0 anobject anObject ��
�� 
nmbr�� ��& ��	-��������  0 compareobjects compareObjects�� �� ��    ������ 0 
leftobject 
leftObject�� 0 rightobject rightObject��   ������ 0 
leftobject 
leftObject�� 0 rightobject rightObject  �� ���� L  OL �� ��K S�
� ��	@����!"��
�� .Lst:DaSonull��� ��� null��  ��  ! ����  0 datecomparator DateComparator" ��	A#��  0 datecomparator DateComparator# ��$����%&��
�� .ascrinit****      � ****$ k     '' 	C(( 	P����  ��  ��  % ������ 0 makekey makeKey��  0 compareobjects compareObjects& )*) ��	F����+,���� 0 makekey makeKey�� ��-�� -  ���� 0 anobject anObject��  + ���� 0 anobject anObject, ��
�� 
ldt �� ��&* ��	R����./����  0 compareobjects compareObjects�� ��0�� 0  ������ 0 
leftobject 
leftObject�� 0 rightobject rightObject��  . ������ 0 
leftobject 
leftObject�� 0 rightobject rightObject/  �� ���� L  OL �� ��K S�
� ��	e����12��
�� .Lst:TeSonull��� ��� null��  �� ��3��
�� 
Cons3 {��������  0 orderingoption orderingOption��  
�� SrtECmpI��  1 ������������������  0 orderingoption orderingOption�� B0 currentconsiderationscomparator CurrentConsiderationsComparator�� >0 caseinsensitivetextcomparator CaseInsensitiveTextComparator�� :0 casesensitivetextcomparator CaseSensitiveTextComparator�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo2 ��	p4����	�5����	�6��������������	���7
������ B0 currentconsiderationscomparator CurrentConsiderationsComparator4 ��8����9:��
�� .ascrinit****      � ****8 k     ;; 	r<< 	����  ��  ��  9 ������ 0 makekey makeKey��  0 compareobjects compareObjects: =>= ��	u����?@���� 0 makekey makeKey�� ��A�� A  ���� 0 anobject anObject��  ? ���� 0 anobject anObject@ ��
�� 
ctxt�� ��&> ��	�����BC����  0 compareobjects compareObjects�� ��D�� D  ������ 0 
leftobject 
leftObject�� 0 rightobject rightObject��  B ������ 0 
leftobject 
leftObject�� 0 rightobject rightObjectC ������ 
�� .ascrcmnt****      � ****�� (�������vj O�� iY �� kY j�� L  OL 
�� SrtECmpI�� >0 caseinsensitivetextcomparator CaseInsensitiveTextComparator5 ��E����FG��
�� .ascrinit****      � ****E k     HH 	�II 	���  ��  ��  F �~�}
�~ 
pare�}  0 compareobjects compareObjectsG �|J
�| 
pareJ �{	��z�yKL�x�{  0 compareobjects compareObjects�z �wM�w M  �v�u�v 0 
leftobject 
leftObject�u 0 rightobject rightObject�y  K �t�s�t 0 
leftobject 
leftObject�s 0 rightobject rightObjectL 	�	��r�r  0 compareobjects compareObjects�x �� )��ld*J V�� b  N  OL 
�� SrtECmpC�� :0 casesensitivetextcomparator CaseSensitiveTextComparator6 �qN�p�oOP�n
�q .ascrinit****      � ****N k     QQ 	�RR 	��m�m  �p  �o  O �l�k
�l 
pare�k  0 compareobjects compareObjectsP �jS
�j 
pareS �i	��h�gTU�f�i  0 compareobjects compareObjects�h �eV�e V  �d�c�d 0 
leftobject 
leftObject�c 0 rightobject rightObject�g  T �b�a�b 0 
leftobject 
leftObject�a 0 rightobject rightObjectU 	�	��`�`  0 compareobjects compareObjects�f �� )��ld*J V�n b  N  OL 
�� SrtECmpD
�� 
errn���Y
�� 
erob
�� 
errt
�� 
enum�� �� 0 etext eText7 �_�^W
�_ 
errn�^ 0 enumber eNumberW �]�\X
�] 
erob�\ 0 efrom eFromX �[�Z�Y
�[ 
errt�Z 
0 eto eTo�Y  �� �� 
0 _error  �� c N��K S�O��  ��K S�O�Y 0��  ��K 
S�O�Y ��  �Y )����a a a W X  *a ����a + 
� �X
�W�VYZ�U
�X .Lst:LiUSnull���     ****�W 0 thelist theList�V  Y 
�T�S�R�Q�P�O�N�M�L�K�T 0 thelist theList�S 0 
resultlist 
resultList�R 0 len  �Q 0 lastnum lastNum�P 0 idx1  �O 0 idx2  �N 0 etext eText�M 0 enumber eNumber�L 0 efrom eFrom�K 
0 eto eToZ 
+�J�I�H�G�F�E
A�D�C�B�A[
��@�?�J "0 aslistparameter asListParameter
�I 
cobj
�H 
leng
�G misccura
�F 
from
�E 
to  �D 
�C .sysorandnmbr    ��� nmbr�B  J��A 0 etext eText[ �>�=\
�> 
errn�= 0 enumber eNumber\ �<�;]
�< 
erob�; 0 efrom eFrom] �:�9�8
�: 
errt�9 
0 eto eTo�8  �@ �? 
0 _error  �U � ob  ��l+ �-E�O��,E�O� *�k��� 	UE�O ?k�kh �� �#E�O��#kE�O��/E��/ElvE[�k/��/FZ[�l/��/FZ[OY��O�W X  *������+ ascr  ��ޭ