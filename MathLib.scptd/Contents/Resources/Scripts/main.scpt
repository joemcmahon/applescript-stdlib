FasdUAS 1.101.10   ��   ��    k             l      ��  ��   y Math -- common math functions

Notes:

- Some handlers originally based on ESG MathLib <http://www.esglabs.com/>, which in turn are conversions of the ones in the Cephes Mathematical Library by Stephen L. Moshier <http://netlib.org/cephes/>.


TO DO: 

- BUG: allowing fixed �1.0e-9 difference between numbers is problematic as it doesn't work for comparisons between two very large or two very small numbers; e.g. `cmp{1e-100,2e-100}` should return -1 (1<2) but returns 0 (1=2); what it really needs to do is calculate `N�N*1e-9` and use that as the margin (with special-case for where N=0); also fix this bug in TestLib's `numeric equality check`; in addition, this adjustment should only apply when one or both numbers are reals, NOT when both are integers

- BUG: `plain` option in number formatter rounds off fractional numbers to whole, which is no good; need to use decimal/scientific for `canonical` representation (c.f. AS always uses decimal notation for `integer` numbers and switches from decimal to sci notations for `real` numbers at approximately >�1e4 and <�1e-3)

- implement `missing value`, `current number locale` constants for use in `for locale` parameter; this avoids need to import TextLib just to call its `current locale` command (Q. is it possible to define same constant in multiple libraries without compiler complaining? if so, just redefine `current locale` constant in all libraries that use `for locale` and rename commands to `current locale name` and `all locale names`)

- decide name: 'Math' or 'Number'? (the latter might be a better choice as this library not only provides standard math functions but general number manipulation too)

- what else needs implemented? e.g. atan2? (note that trivial operations such as `hypotenuse`, `square` and `square root` are not implemented as those are simple to do using AS's existing `^` operator (e.g. sqrt(n)=n^0.5), while `floor`, `ceil`, etc. are already covered by `round number`


- add optional parameter to `format number` for specifying decimal places and padding (these are common tasks, so accept e.g. a record containing one or more of: [maximum] decimal places, minimum decimal places, rounding method, minimum integral places)

- `format number` and `round number` should both support the same rounding options (i.e. all rounding behaviors supported by NSNumberFormatter)


- `parse/format hexadecimal number` should include support for parsing/formatting list of numbers as single hex string, based on fixed-width hex sequences (i.e. add optional `of width INTEGER` parameter to both commands; if given, switch from single-integer to list-of-integer mode)

- what about NSByteCountFormatter, NSEnergyFormatter, NSMassFormatter, NSLengthFormatter, MKDistanceFormatter? Also, is it worth trying to support AS's largely neglected and awkwardly incomplete unit types, or is it better just to leave those to do their own thing (i.e. limited range unit conversions) and deal solely with plain numbers? If the latter, would it be worth provided more comprehensive `convert [length/mass/volume/etc] NUMBER from UNIT to UNIT` commands here, eliminating the need for users to use AS's unit types completely?
     � 	 	�   M a t h   - -   c o m m o n   m a t h   f u n c t i o n s 
 
 N o t e s : 
 
 -   S o m e   h a n d l e r s   o r i g i n a l l y   b a s e d   o n   E S G   M a t h L i b   < h t t p : / / w w w . e s g l a b s . c o m / > ,   w h i c h   i n   t u r n   a r e   c o n v e r s i o n s   o f   t h e   o n e s   i n   t h e   C e p h e s   M a t h e m a t i c a l   L i b r a r y   b y   S t e p h e n   L .   M o s h i e r   < h t t p : / / n e t l i b . o r g / c e p h e s / > . 
 
 
 T O   D O :   
 
 -   B U G :   a l l o w i n g   f i x e d   � 1 . 0 e - 9   d i f f e r e n c e   b e t w e e n   n u m b e r s   i s   p r o b l e m a t i c   a s   i t   d o e s n ' t   w o r k   f o r   c o m p a r i s o n s   b e t w e e n   t w o   v e r y   l a r g e   o r   t w o   v e r y   s m a l l   n u m b e r s ;   e . g .   ` c m p { 1 e - 1 0 0 , 2 e - 1 0 0 } `   s h o u l d   r e t u r n   - 1   ( 1 < 2 )   b u t   r e t u r n s   0   ( 1 = 2 ) ;   w h a t   i t   r e a l l y   n e e d s   t o   d o   i s   c a l c u l a t e   ` N � N * 1 e - 9 `   a n d   u s e   t h a t   a s   t h e   m a r g i n   ( w i t h   s p e c i a l - c a s e   f o r   w h e r e   N = 0 ) ;   a l s o   f i x   t h i s   b u g   i n   T e s t L i b ' s   ` n u m e r i c   e q u a l i t y   c h e c k ` ;   i n   a d d i t i o n ,   t h i s   a d j u s t m e n t   s h o u l d   o n l y   a p p l y   w h e n   o n e   o r   b o t h   n u m b e r s   a r e   r e a l s ,   N O T   w h e n   b o t h   a r e   i n t e g e r s 
 
 -   B U G :   ` p l a i n `   o p t i o n   i n   n u m b e r   f o r m a t t e r   r o u n d s   o f f   f r a c t i o n a l   n u m b e r s   t o   w h o l e ,   w h i c h   i s   n o   g o o d ;   n e e d   t o   u s e   d e c i m a l / s c i e n t i f i c   f o r   ` c a n o n i c a l `   r e p r e s e n t a t i o n   ( c . f .   A S   a l w a y s   u s e s   d e c i m a l   n o t a t i o n   f o r   ` i n t e g e r `   n u m b e r s   a n d   s w i t c h e s   f r o m   d e c i m a l   t o   s c i   n o t a t i o n s   f o r   ` r e a l `   n u m b e r s   a t   a p p r o x i m a t e l y   > � 1 e 4   a n d   < � 1 e - 3 ) 
 
 -   i m p l e m e n t   ` m i s s i n g   v a l u e ` ,   ` c u r r e n t   n u m b e r   l o c a l e `   c o n s t a n t s   f o r   u s e   i n   ` f o r   l o c a l e `   p a r a m e t e r ;   t h i s   a v o i d s   n e e d   t o   i m p o r t   T e x t L i b   j u s t   t o   c a l l   i t s   ` c u r r e n t   l o c a l e `   c o m m a n d   ( Q .   i s   i t   p o s s i b l e   t o   d e f i n e   s a m e   c o n s t a n t   i n   m u l t i p l e   l i b r a r i e s   w i t h o u t   c o m p i l e r   c o m p l a i n i n g ?   i f   s o ,   j u s t   r e d e f i n e   ` c u r r e n t   l o c a l e `   c o n s t a n t   i n   a l l   l i b r a r i e s   t h a t   u s e   ` f o r   l o c a l e `   a n d   r e n a m e   c o m m a n d s   t o   ` c u r r e n t   l o c a l e   n a m e `   a n d   ` a l l   l o c a l e   n a m e s ` ) 
 
 -   d e c i d e   n a m e :   ' M a t h '   o r   ' N u m b e r ' ?   ( t h e   l a t t e r   m i g h t   b e   a   b e t t e r   c h o i c e   a s   t h i s   l i b r a r y   n o t   o n l y   p r o v i d e s   s t a n d a r d   m a t h   f u n c t i o n s   b u t   g e n e r a l   n u m b e r   m a n i p u l a t i o n   t o o ) 
 
 -   w h a t   e l s e   n e e d s   i m p l e m e n t e d ?   e . g .   a t a n 2 ?   ( n o t e   t h a t   t r i v i a l   o p e r a t i o n s   s u c h   a s   ` h y p o t e n u s e ` ,   ` s q u a r e `   a n d   ` s q u a r e   r o o t `   a r e   n o t   i m p l e m e n t e d   a s   t h o s e   a r e   s i m p l e   t o   d o   u s i n g   A S ' s   e x i s t i n g   ` ^ `   o p e r a t o r   ( e . g .   s q r t ( n ) = n ^ 0 . 5 ) ,   w h i l e   ` f l o o r ` ,   ` c e i l ` ,   e t c .   a r e   a l r e a d y   c o v e r e d   b y   ` r o u n d   n u m b e r ` 
 
 
 -   a d d   o p t i o n a l   p a r a m e t e r   t o   ` f o r m a t   n u m b e r `   f o r   s p e c i f y i n g   d e c i m a l   p l a c e s   a n d   p a d d i n g   ( t h e s e   a r e   c o m m o n   t a s k s ,   s o   a c c e p t   e . g .   a   r e c o r d   c o n t a i n i n g   o n e   o r   m o r e   o f :   [ m a x i m u m ]   d e c i m a l   p l a c e s ,   m i n i m u m   d e c i m a l   p l a c e s ,   r o u n d i n g   m e t h o d ,   m i n i m u m   i n t e g r a l   p l a c e s ) 
 
 -   ` f o r m a t   n u m b e r `   a n d   ` r o u n d   n u m b e r `   s h o u l d   b o t h   s u p p o r t   t h e   s a m e   r o u n d i n g   o p t i o n s   ( i . e .   a l l   r o u n d i n g   b e h a v i o r s   s u p p o r t e d   b y   N S N u m b e r F o r m a t t e r ) 
 
 
 -   ` p a r s e / f o r m a t   h e x a d e c i m a l   n u m b e r `   s h o u l d   i n c l u d e   s u p p o r t   f o r   p a r s i n g / f o r m a t t i n g   l i s t   o f   n u m b e r s   a s   s i n g l e   h e x   s t r i n g ,   b a s e d   o n   f i x e d - w i d t h   h e x   s e q u e n c e s   ( i . e .   a d d   o p t i o n a l   ` o f   w i d t h   I N T E G E R `   p a r a m e t e r   t o   b o t h   c o m m a n d s ;   i f   g i v e n ,   s w i t c h   f r o m   s i n g l e - i n t e g e r   t o   l i s t - o f - i n t e g e r   m o d e ) 
 
 -   w h a t   a b o u t   N S B y t e C o u n t F o r m a t t e r ,   N S E n e r g y F o r m a t t e r ,   N S M a s s F o r m a t t e r ,   N S L e n g t h F o r m a t t e r ,   M K D i s t a n c e F o r m a t t e r ?   A l s o ,   i s   i t   w o r t h   t r y i n g   t o   s u p p o r t   A S ' s   l a r g e l y   n e g l e c t e d   a n d   a w k w a r d l y   i n c o m p l e t e   u n i t   t y p e s ,   o r   i s   i t   b e t t e r   j u s t   t o   l e a v e   t h o s e   t o   d o   t h e i r   o w n   t h i n g   ( i . e .   l i m i t e d   r a n g e   u n i t   c o n v e r s i o n s )   a n d   d e a l   s o l e l y   w i t h   p l a i n   n u m b e r s ?   I f   t h e   l a t t e r ,   w o u l d   i t   b e   w o r t h   p r o v i d e d   m o r e   c o m p r e h e n s i v e   ` c o n v e r t   [ l e n g t h / m a s s / v o l u m e / e t c ]   N U M B E R   f r o m   U N I T   t o   U N I T `   c o m m a n d s   h e r e ,   e l i m i n a t i n g   t h e   n e e d   f o r   u s e r s   t o   u s e   A S ' s   u n i t   t y p e s   c o m p l e t e l y ? 
   
  
 l     ��������  ��  ��        l     ��������  ��  ��        x     �� ����    4    �� 
�� 
frmk  m       �    F o u n d a t i o n��        l     ��������  ��  ��        x    �� ����    2   ��
�� 
osax��        l     ��������  ��  ��        l     ��  ��    J D--------------------------------------------------------------------     �   � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -     !   l     �� " #��   "   support    # � $ $    s u p p o r t !  % & % l     ��������  ��  ��   &  ' ( ' l      ) * + ) j    �� ,�� 0 _supportlib _supportLib , N     - - 4    �� .
�� 
scpt . m     / / � 0 0 " L i b r a r y S u p p o r t L i b * "  used for parameter checking    + � 1 1 8   u s e d   f o r   p a r a m e t e r   c h e c k i n g (  2 3 2 l     ��������  ��  ��   3  4 5 4 i   ! 6 7 6 I      �� 8���� 
0 _error   8  9 : 9 o      ���� 0 handlername handlerName :  ; < ; o      ���� 0 etext eText <  = > = o      ���� 0 enumber eNumber >  ? @ ? o      ���� 0 efrom eFrom @  A�� A o      ���� 
0 eto eTo��  ��   7 n     B C B I    �� D���� &0 throwcommanderror throwCommandError D  E F E m     G G � H H  M a t h L i b F  I J I o    ���� 0 handlername handlerName J  K L K o    ���� 0 etext eText L  M N M o    	���� 0 enumber eNumber N  O P O o   	 
���� 0 efrom eFrom P  Q�� Q o   
 ���� 
0 eto eTo��  ��   C o     ���� 0 _supportlib _supportLib 5  R S R l     ��������  ��  ��   S  T U T l     ��������  ��  ��   U  V W V l     �� X Y��   X J D--------------------------------------------------------------------    Y � Z Z � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - W  [ \ [ l     �� ] ^��   ]  
 constants    ^ � _ _    c o n s t a n t s \  ` a ` l     ��������  ��  ��   a  b c b l      d e f d j   " $�� g�� 	0 __e__   g m   " # h h @�
�_� e ; 5 The mathematical constant e (natural logarithm base)    f � i i j   T h e   m a t h e m a t i c a l   c o n s t a n t   e   ( n a t u r a l   l o g a r i t h m   b a s e ) c  j k j l     ��������  ��  ��   k  l m l j   % '�� n�� 0 _isequaldelta _isEqualDelta n m   % & o o >.�&֕ m  p q p l     ��������  ��  ��   q  r s r l     �� t u��   t a [ pre-calculated values (0-360� in 15� increments) -- TO DO: precalculate for 1� increments?    u � v v �   p r e - c a l c u l a t e d   v a l u e s   ( 0 - 3 6 0 �   i n   1 5 �   i n c r e m e n t s )   - -   T O   D O :   p r e c a l c u l a t e   f o r   1 �   i n c r e m e n t s ? s  w x w j   ( e�� y�� 0 _precalcsine _precalcSine y J   ( d z z  { | { m   ( ) } }          |  ~  ~ m   ) * � � ?А}��(J   � � � m   * + � � ?�       �  � � � m   + , � � ?栞fK� �  � � � m   , / � � ?�z�X=; �  � � � m   / 2 � � ?���GH�� �  � � � m   2 5 � � ?�       �  � � � m   5 8 � � ?���GH�� �  � � � m   8 ; � � ?�z�X=; �  � � � m   ; < � � ?栞fK� �  � � � m   < = � � ?�       �  � � � m   = > � � ?А}��(J �  � � � m   > ? � �          �  � � � m   ? B � � �А}��(J �  � � � m   B E � � ��       �  � � � m   E H � � �栞fK� �  � � � m   H K � � ��z�X=; �  � � � m   K N � � ����GH�� �  � � � m   N Q � � ��       �  � � � m   Q T � � ����GH�� �  � � � m   T W � � ��z�X=; �  � � � m   W Z � � �栞fK� �  � � � m   Z ] � � ��       �  ��� � m   ] ` � � �А}��(J��   x  � � � j   f ��� ��� "0 _precalctangent _precalcTangent � J   f � � �  � � � m   f g � �          �  � � � m   g j � � ?�&^�Ĵ �  � � � m   j m � � ?�y�E�@G �  � � � m   m p � � ?�       �  � � � m   p s � � ?��z�XN� �  � � � m   s v � � @�=t,'j �  � � � m   v y��
�� 
msng �  � � � m   y | � � ��=t,'j �  � � � m   |  � � ���z�XN� �  � � � m    � � � ��       �  � � � m   � � � � ��y�E�@G �  � � � m   � � � � ��&^�Ĵ �  � � � m   � � � �          �  � � � m   � � � � ?�&^�Ĵ �  � � � m   � � � � ?�y�E�@G �  � � � m   � � � � ?�       �  � � � m   � � � � ?��z�XN� �  � � � m   � � � � @�=t,'j �  � � � m   � ���
�� 
msng �  � � � m   � � � � ��=t,'j �    m   � � ���z�XN�  m   � � ��        m   � � ��y�E�@G 	��	 m   � �

 ��&^�Ĵ��   �  l     ��������  ��  ��    l     ��������  ��  ��    l     ����   J D--------------------------------------------------------------------    � � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  l     ����     parse and format    � "   p a r s e   a n d   f o r m a t  l     ��������  ��  ��    i  � � I      ������ ,0 _makenumberformatter _makeNumberFormatter  !  o      ���� 0 formatstyle formatStyle! "��" o      ���� 0 
localecode 
localeCode��  ��   k     �## $%$ r     &'& n    ()( I    �������� 0 init  ��  ��  ) n    *+* I    �������� 	0 alloc  ��  ��  + n    ,-, o    ���� &0 nsnumberformatter NSNumberFormatter- m     ��
�� misccura' o      ���� 0 asocformatter asocFormatter% ./. Z    �01230 =   454 o    ���� 0 formatstyle formatStyle5 m    ��
�� FNStFNS01 l   6786 n   9:9 I    ��;���� "0 setnumberstyle_ setNumberStyle_; <��< l   =����= n   >?> o    ���� 40 nsnumberformatternostyle NSNumberFormatterNoStyle? m    ��
�� misccura��  ��  ��  ��  : o    ���� 0 asocformatter asocFormatter7 � � TO DO: why does NSNumberFormatterNoStyle omit decimal places? address that, or seriously consider using NSNumberFormatterScientificStyle, or some combination of that and NSNumberFormatterDecimalStyle (minus thousands separators) as default   8 �@@�   T O   D O :   w h y   d o e s   N S N u m b e r F o r m a t t e r N o S t y l e   o m i t   d e c i m a l   p l a c e s ?   a d d r e s s   t h a t ,   o r   s e r i o u s l y   c o n s i d e r   u s i n g   N S N u m b e r F o r m a t t e r S c i e n t i f i c S t y l e ,   o r   s o m e   c o m b i n a t i o n   o f   t h a t   a n d   N S N u m b e r F o r m a t t e r D e c i m a l S t y l e   ( m i n u s   t h o u s a n d s   s e p a r a t o r s )   a s   d e f a u l t2 ABA =   "CDC o     ���� 0 formatstyle formatStyleD m     !��
�� FNStFNS1B EFE l  % -GHIG n  % -JKJ I   & -��L���� "0 setnumberstyle_ setNumberStyle_L M��M l  & )N����N n  & )OPO o   ' )���� >0 nsnumberformatterdecimalstyle NSNumberFormatterDecimalStyleP m   & '��
�� misccura��  ��  ��  ��  K o   % &���� 0 asocformatter asocFormatterH - ' uses thousands separators, no exponent   I �QQ N   u s e s   t h o u s a n d s   s e p a r a t o r s ,   n o   e x p o n e n tF RSR =  0 3TUT o   0 1���� 0 formatstyle formatStyleU m   1 2��
�� FNStFNS2S VWV l  6 >XYZX n  6 >[\[ I   7 >��]���� "0 setnumberstyle_ setNumberStyle_] ^��^ l  7 :_����_ n  7 :`a` o   8 :���� @0 nsnumberformattercurrencystyle NSNumberFormatterCurrencyStylea m   7 8��
�� misccura��  ��  ��  ��  \ o   6 7���� 0 asocformatter asocFormatterY   adds currency symbol   Z �bb *   a d d s   c u r r e n c y   s y m b o lW cdc =  A Defe o   A B�� 0 formatstyle formatStylef m   B C�~
�~ FNStFNS3d ghg l  G Oijki n  G Olml I   H O�}n�|�} "0 setnumberstyle_ setNumberStyle_n o�{o l  H Kp�z�yp n  H Kqrq o   I K�x�x >0 nsnumberformatterpercentstyle NSNumberFormatterPercentStyler m   H I�w
�w misccura�z  �y  �{  �|  m o   G H�v�v 0 asocformatter asocFormatterj ( " multiplies by 100 and appends '%'   k �ss D   m u l t i p l i e s   b y   1 0 0   a n d   a p p e n d s   ' % 'h tut =  R Uvwv o   R S�u�u 0 formatstyle formatStylew m   S T�t
�t FNStFNS4u xyx l  X `z{|z n  X `}~} I   Y `�s�r�s "0 setnumberstyle_ setNumberStyle_ ��q� l  Y \��p�o� n  Y \��� o   Z \�n�n D0  nsnumberformatterscientificstyle  NSNumberFormatterScientificStyle� m   Y Z�m
�m misccura�p  �o  �q  �r  ~ o   X Y�l�l 0 asocformatter asocFormatter{   uses exponent notation   | ��� .   u s e s   e x p o n e n t   n o t a t i o ny ��� =  c f��� o   c d�k�k 0 formatstyle formatStyle� m   d e�j
�j FNStFNS5� ��i� l  i s���� n  i s��� I   j s�h��g�h "0 setnumberstyle_ setNumberStyle_� ��f� l  j o��e�d� n  j o��� o   k o�c�c @0 nsnumberformatterspelloutstyle NSNumberFormatterSpellOutStyle� m   j k�b
�b misccura�e  �d  �f  �g  � o   i j�a�a 0 asocformatter asocFormatter�   uses words   � ���    u s e s   w o r d s�i  3 R   v ��`��
�` .ascrerr ****      � ****� m   � ��� ��� b I n v a l i d    i n    p a r a m e t e r   ( n o t   a n   a l l o w e d   c o n s t a n t ) .� �_��
�_ 
errn� m   z }�^�^�Y� �]��
�] 
erob� o   � ��\�\ 0 formatstyle formatStyle� �[��Z
�[ 
errt� m   � ��Y
�Y 
enum�Z  / ��� n  � ���� I   � ��X��W�X 0 
setlocale_ 
setLocale_� ��V� l  � ���U�T� n  � ���� I   � ��S��R�S &0 aslocaleparameter asLocaleParameter� ��� o   � ��Q�Q 0 
localecode 
localeCode� ��P� m   � ��� ���  f o r   l o c a l e�P  �R  � o   � ��O�O 0 _supportlib _supportLib�U  �T  �V  �W  � o   � ��N�N 0 asocformatter asocFormatter� ��M� L   � ��� o   � ��L�L 0 asocformatter asocFormatter�M   ��� l     �K�J�I�K  �J  �I  � ��� l     �H�G�F�H  �G  �F  � ��� l     �E�D�C�E  �D  �C  � ��� l     �B�A�@�B  �A  �@  � ��� l     �?�>�=�?  �>  �=  � ��� l     �<���<  � � � TO DO: merge the following handlers' functionality into `formatNumber` and `parseNumber`, making sure that canonical format is the default when no other options are given (might be best to implement as special case)   � ����   T O   D O :   m e r g e   t h e   f o l l o w i n g   h a n d l e r s '   f u n c t i o n a l i t y   i n t o   ` f o r m a t N u m b e r `   a n d   ` p a r s e N u m b e r ` ,   m a k i n g   s u r e   t h a t   c a n o n i c a l   f o r m a t   i s   t h e   d e f a u l t   w h e n   n o   o t h e r   o p t i o n s   a r e   g i v e n   ( m i g h t   b e   b e s t   t o   i m p l e m e n t   a s   s p e c i a l   c a s e )� ��� l     �;�:�9�;  �:  �9  � ��� i  � ���� I      �8�7�6�8 60 _canonicalnumberformatter _canonicalNumberFormatter�7  �6  � k     &�� ��� r     ��� n    ��� I    �5�4�3�5 0 init  �4  �3  � n    ��� I    �2�1�0�2 	0 alloc  �1  �0  � n    ��� o    �/�/ &0 nsnumberformatter NSNumberFormatter� m     �.
�. misccura� o      �-�- 0 asocformatter asocFormatter� ��� n   ��� I    �,��+�, "0 setnumberstyle_ setNumberStyle_� ��*� l   ��)�(� n   ��� o    �'�' D0  nsnumberformatterscientificstyle  NSNumberFormatterScientificStyle� m    �&
�& misccura�)  �(  �*  �+  � o    �%�% 0 asocformatter asocFormatter� ��� l   #���� n   #��� I    #�$��#�$ 0 
setlocale_ 
setLocale_� ��"� l   ��!� � n   ��� I    ���� 0 systemlocale systemLocale�  �  � n   ��� o    �� 0 nslocale NSLocale� m    �
� misccura�!  �   �"  �#  � o    �� 0 asocformatter asocFormatter� [ U note: NSNumberFormatter uses currentLocale by default, which isn't what we want here   � ��� �   n o t e :   N S N u m b e r F o r m a t t e r   u s e s   c u r r e n t L o c a l e   b y   d e f a u l t ,   w h i c h   i s n ' t   w h a t   w e   w a n t   h e r e� ��� L   $ &�� o   $ %�� 0 asocformatter asocFormatter�  � ��� l     ����  �  �  � ��� l     ����  �  �  � ��� i  � ���� I      ���� ,0 _convertnumbertotext _convertNumberToText� ��� o      �� 0 	thenumber 	theNumber�  �  � Q     B���� k    0�� ��� Z    "����� =    ��� l   ���
� I   �	��
�	 .corecnte****       ****� J       � o    �� 0 	thenumber 	theNumber�  � ��
� 
kocl m    �
� 
nmbr�  �  �
  � m    ��  � l    n    I    ��� 60 throwinvalidparametertype throwInvalidParameterType 	
	 o    � �  0 	thenumber 	theNumber
  m     �    m     �  n u m b e r �� m    ��
�� 
nmbr��  �   o    ���� 0 _supportlib _supportLib � � only accept integer or real types (i.e. allowing a text parameter to be coerced to number would defeat the purpose of these handlers, which is to guarantee non-localized conversions)    �n   o n l y   a c c e p t   i n t e g e r   o r   r e a l   t y p e s   ( i . e .   a l l o w i n g   a   t e x t   p a r a m e t e r   t o   b e   c o e r c e d   t o   n u m b e r   w o u l d   d e f e a t   t h e   p u r p o s e   o f   t h e s e   h a n d l e r s ,   w h i c h   i s   t o   g u a r a n t e e   n o n - l o c a l i z e d   c o n v e r s i o n s )�  �  � �� L   # 0 c   # / l  # -���� n  # - I   ( -������ &0 stringfromnumber_ stringFromNumber_ �� o   ( )���� 0 	thenumber 	theNumber��  ��   I   # (�������� 60 _canonicalnumberformatter _canonicalNumberFormatter��  ��  ��  ��   m   - .��
�� 
ctxt��  � R      ��
�� .ascrerr ****      � **** o      ���� 0 etext eText �� !
�� 
errn  o      ���� 0 enumber eNumber! ��"#
�� 
erob" o      ���� 0 efrom eFrom# ��$��
�� 
errt$ o      ���� 
0 eto eTo��  � I   8 B��%���� 
0 _error  % &'& m   9 :(( �)) , c o n v e r t   n u m b e r   t o   t e x t' *+* o   : ;���� 0 etext eText+ ,-, o   ; <���� 0 enumber eNumber- ./. o   < =���� 0 efrom eFrom/ 0��0 o   = >���� 
0 eto eTo��  ��  � 121 l     ��������  ��  ��  2 343 l     ��������  ��  ��  4 565 i  � �787 I      ��9���� ,0 _converttexttonumber _convertTextToNumber9 :��: o      ���� 0 thetext theText��  ��  8 Q     ];<=; k    G>> ?@? Z    "AB����A =    CDC l   E����E I   ��FG
�� .corecnte****       ****F J    HH I��I o    ���� 0 thetext theText��  G ��J��
�� 
koclJ m    ��
�� 
ctxt��  ��  ��  D m    ����  B l   KLMK n   NON I    ��P���� 60 throwinvalidparametertype throwInvalidParameterTypeP QRQ o    ���� 0 thetext theTextR STS m    UU �VV  T WXW m    YY �ZZ  t e x tX [��[ m    ��
�� 
ctxt��  ��  O o    ���� 0 _supportlib _supportLibL � � only accept text (i.e. allowing an integer/real parameter to be coerced to text would defeat the purpose of these handlers, which is to guarantee non-localized conversions)   M �\\Z   o n l y   a c c e p t   t e x t   ( i . e .   a l l o w i n g   a n   i n t e g e r / r e a l   p a r a m e t e r   t o   b e   c o e r c e d   t o   t e x t   w o u l d   d e f e a t   t h e   p u r p o s e   o f   t h e s e   h a n d l e r s ,   w h i c h   i s   t o   g u a r a n t e e   n o n - l o c a l i z e d   c o n v e r s i o n s )��  ��  @ ]^] r   # /_`_ n  # -aba I   ( -��c���� &0 numberfromstring_ numberFromString_c d��d o   ( )���� 0 thetext theText��  ��  b I   # (�������� 60 _canonicalnumberformatter _canonicalNumberFormatter��  ��  ` o      ���� 0 	theresult 	theResult^ efe Z  0 Bgh����g =  0 3iji o   0 1���� 0 	theresult 	theResultj m   1 2��
�� 
msngh R   6 >��kl
�� .ascrerr ****      � ****k m   < =mm �nn Z T e x t   v a l u e   i s n  t   a n   A p p l e S c r i p t - s t y l e   n u m b e r .l ��op
�� 
errno m   8 9�����Yp ��q��
�� 
erobq o   : ;���� 0 thetext theText��  ��  ��  f r��r L   C Gss c   C Ftut o   C D���� 0 	theresult 	theResultu m   D E��
�� 
****��  < R      ��vw
�� .ascrerr ****      � ****v o      ���� 0 etext eTextw ��xy
�� 
errnx o      ���� 0 enumber eNumbery ��z{
�� 
erobz o      ���� 0 efrom eFrom{ ��|��
�� 
errt| o      ���� 
0 eto eTo��  = I   O ]��}���� 
0 _error  } ~~ m   P S�� ��� , c o n v e r t   t e x t   t o   n u m b e r ��� o   S T���� 0 etext eText� ��� o   T U���� 0 enumber eNumber� ��� o   U V���� 0 efrom eFrom� ���� o   V W���� 
0 eto eTo��  ��  6 ��� l     ��������  ��  ��  � ��� l     ������  �  -----   � ��� 
 - - - - -� ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  � ���� I     ����
�� .Mth:FNumnull���     nmbr� o      ���� 0 	thenumber 	theNumber� ����
�� 
Usin� |����������  ��  � o      ���� 0 formatstyle formatStyle��  � l     ������ m      ��
�� FNStFNS0��  ��  � �����
�� 
Loca� |����������  ��  � o      ���� 0 
localecode 
localeCode��  � l     ������ m      ��
�� 
msng��  ��  ��  � l    M���� k     M�� ��� l      ������  �zt -setRoundingMode:
		NSNumberFormatterRoundCeiling
		NSNumberFormatterRoundFloor
		NSNumberFormatterRoundDown -- toward zero
		NSNumberFormatterRoundUp -- away from zero (aka `as taught in school`)
		NSNumberFormatterRoundHalfEven
		NSNumberFormatterRoundHalfDown -- note that `round number` currently doesn't support half-down and half-up
		NSNumberFormatterRoundHalfUp
	   � ����   - s e t R o u n d i n g M o d e : 
 	 	 N S N u m b e r F o r m a t t e r R o u n d C e i l i n g 
 	 	 N S N u m b e r F o r m a t t e r R o u n d F l o o r 
 	 	 N S N u m b e r F o r m a t t e r R o u n d D o w n   - -   t o w a r d   z e r o 
 	 	 N S N u m b e r F o r m a t t e r R o u n d U p   - -   a w a y   f r o m   z e r o   ( a k a   ` a s   t a u g h t   i n   s c h o o l ` ) 
 	 	 N S N u m b e r F o r m a t t e r R o u n d H a l f E v e n 
 	 	 N S N u m b e r F o r m a t t e r R o u n d H a l f D o w n   - -   n o t e   t h a t   ` r o u n d   n u m b e r `   c u r r e n t l y   d o e s n ' t   s u p p o r t   h a l f - d o w n   a n d   h a l f - u p 
 	 	 N S N u m b e r F o r m a t t e r R o u n d H a l f U p 
 	� ���� Q     M���� k    ;�� ��� r    ��� n   ��� I    ������� &0 asnumberparameter asNumberParameter� ��� o    	���� 0 	thenumber 	theNumber� ��� m   	 
�� ���  �  ��  � o    �~�~ 0 _supportlib _supportLib� o      �}�} 0 	thenumber 	theNumber� ��� r    ��� I    �|��{�| ,0 _makenumberformatter _makeNumberFormatter� ��� o    �z�z 0 formatstyle formatStyle� ��y� o    �x�x 0 
localecode 
localeCode�y  �{  � o      �w�w 0 asocformatter asocFormatter� ��� r    #��� n   !��� I    !�v��u�v &0 stringfromnumber_ stringFromNumber_� ��t� o    �s�s 0 	thenumber 	theNumber�t  �u  � o    �r�r 0 asocformatter asocFormatter� o      �q�q 0 
asocstring 
asocString� ��� l  $ 6���� Z  $ 6���p�o� =  $ '��� o   $ %�n�n 0 
asocstring 
asocString� m   % &�m
�m 
msng� R   * 2�l��
�l .ascrerr ****      � ****� m   0 1�� ��� $ A n   e r r o r   o c c u r r e d .� �k��
�k 
errn� m   , -�j�j�Y� �i��h
�i 
erob� o   . /�g�g 0 	thenumber 	theNumber�h  �p  �o  � n h shouldn't fail, but -stringFromNumber:'s return type isn't declared as non-nullable so check to be sure   � ��� �   s h o u l d n ' t   f a i l ,   b u t   - s t r i n g F r o m N u m b e r : ' s   r e t u r n   t y p e   i s n ' t   d e c l a r e d   a s   n o n - n u l l a b l e   s o   c h e c k   t o   b e   s u r e� ��f� L   7 ;�� c   7 :��� o   7 8�e�e 0 
asocstring 
asocString� m   8 9�d
�d 
ctxt�f  � R      �c��
�c .ascrerr ****      � ****� o      �b�b 0 etext eText� �a��
�a 
errn� o      �`�` 0 enumber eNumber� �_��
�_ 
erob� o      �^�^ 0 efrom eFrom� �]��\
�] 
errt� o      �[�[ 
0 eto eTo�\  � I   C M�Z��Y�Z 
0 _error  � ��� m   D E�� ���  f o r m a t   n u m b e r� ��� o   E F�X�X 0 etext eText� ��� o   F G�W�W 0 enumber eNumber� ��� o   G H�V�V 0 efrom eFrom� ��U� o   H I�T�T 
0 eto eTo�U  �Y  ��  � E ? TO DO: optional param for specifying places, padding, rounding   � ��� ~   T O   D O :   o p t i o n a l   p a r a m   f o r   s p e c i f y i n g   p l a c e s ,   p a d d i n g ,   r o u n d i n g� ��� l     �S�R�Q�S  �R  �Q  � ��� l     �P�O�N�P  �O  �N  � ��� i  � ���� I     �M��
�M .Mth:PNumnull���     ctxt� o      �L�L 0 thetext theText� �K 
�K 
Usin  |�J�I�H�J  �I   o      �G�G 0 formatstyle formatStyle�H   l     �F�E m      �D
�D FNStFNS0�F  �E   �C�B
�C 
Loca |�A�@�?�A  �@   o      �>�> 0 
localecode 
localeCode�?   l     �=�< m      �;
�; 
msng�=  �<  �B  � Q     �	
	 k    �  r     n    I    �:�9�: &0 stringwithstring_ stringWithString_ �8 l   �7�6 n    I    �5�4�5 "0 astextparameter asTextParameter  o    �3�3 0 thetext theText �2 m     �  �2  �4   o    �1�1 0 _supportlib _supportLib�7  �6  �8  �9   n    o    �0�0 0 nsstring NSString m    �/
�/ misccura o      �.�. 0 asoctext asocText  !  r    !"#" I    �-$�,�- ,0 _makenumberformatter _makeNumberFormatter$ %&% o    �+�+ 0 formatstyle formatStyle& '�*' o    �)�) 0 
localecode 
localeCode�*  �,  # o      �(�( 0 asocformatter asocFormatter! ()( r   " **+* n  " (,-, I   # (�'.�&�' &0 numberfromstring_ numberFromString_. /�%/ o   # $�$�$ 0 thetext theText�%  �&  - o   " #�#�# 0 asocformatter asocFormatter+ o      �"�" 0 
asocnumber 
asocNumber) 010 Z   + �23�!� 2 =  + .454 o   + ,�� 0 
asocnumber 
asocNumber5 m   , -�
� 
msng3 k   1 �66 787 Z   1 �9:;<9 =  1 4=>= o   1 2�� 0 formatstyle formatStyle> m   2 3�
� FNStFNS0: r   7 :?@? m   7 8AA �BB 
 p l a i n@ o      �� 0 
formatname 
formatName; CDC =  = @EFE o   = >�� 0 formatstyle formatStyleF m   > ?�
� FNStFNS1D GHG r   C FIJI m   C DKK �LL  d e c i m a lJ o      �� 0 
formatname 
formatNameH MNM =  I LOPO o   I J�� 0 formatstyle formatStyleP m   J K�
� FNStFNS2N QRQ r   O RSTS m   O PUU �VV  c u r r e n c yT o      �� 0 
formatname 
formatNameR WXW =  U XYZY o   U V�� 0 formatstyle formatStyleZ m   V W�
� FNStFNS3X [\[ r   [ ^]^] m   [ \__ �``  p e r c e n t^ o      �� 0 
formatname 
formatName\ aba =  a fcdc o   a b�� 0 formatstyle formatStyled m   b e�
� FNStFNS4b efe r   i nghg m   i lii �jj  s c i e n t i f i ch o      �� 0 
formatname 
formatNamef klk =  q vmnm o   q r�� 0 formatstyle formatStylen m   r u�
� FNStFNS5l o�o r   y ~pqp m   y |rr �ss  w o r dq o      �� 0 
formatname 
formatName�  < r   � �tut b   � �vwv b   � �xyx m   � �zz �{{  y o   � ��
�
 0 formatstyle formatStylew m   � �|| �}}  u o      �	�	 0 
formatname 
formatName8 ~~ r   � ���� c   � ���� n  � ���� I   � ����� $0 localeidentifier localeIdentifier�  �  � n  � ���� I   � ����� 
0 locale  �  �  � o   � ��� 0 asocformatter asocFormatter� m   � ��
� 
ctxt� o      � �  $0 localeidentifier localeIdentifier ��� Z   � ������� =   � ���� n  � ���� 1   � ���
�� 
leng� o   � ����� $0 localeidentifier localeIdentifier� m   � �����  � r   � ���� m   � ��� ���  s t a n d a r d� o      ���� $0 localeidentifier localeIdentifier��  � r   � ���� b   � ���� b   � ���� m   � ��� ���  � o   � ����� $0 localeidentifier localeIdentifier� m   � ��� ���  � o      ���� $0 localeidentifier localeIdentifier� ���� R   � �����
�� .ascrerr ****      � ****� l  � ������� b   � ���� b   � ���� b   � ���� b   � ���� m   � ��� ��� \ T e x t   i s   n o t   i n   t h e   c o r r e c t   f o r m a t   ( e x p e c t e d   a  � o   � ����� 0 
formatname 
formatName� m   � ��� ��� 4 - f o r m a t t e d   n u m b e r   f o r   t h e  � o   � ����� $0 localeidentifier localeIdentifier� m   � ��� ���    l o c a l e ) .��  ��  � ����
�� 
errn� m   � ������Y� �����
�� 
erob� o   � ����� 0 thetext theText��  ��  �!  �   1 ��� l  � ���������  ��  ��  � ���� L   � ��� c   � ���� o   � ����� 0 
asocnumber 
asocNumber� m   � ���
�� 
****��  
 R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��   I   � �������� 
0 _error  � ��� m   � ��� ���  p a r s e   n u m b e r� ��� o   � ����� 0 etext eText� ��� o   � ����� 0 enumber eNumber� ��� o   � ����� 0 efrom eFrom� ���� o   � ����� 
0 eto eTo��  ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ������  � J D--------------------------------------------------------------------   � ��� � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -� ��� l     ������  � $  Hexadecimal number conversion   � ��� <   H e x a d e c i m a l   n u m b e r   c o n v e r s i o n� ��� l     ��������  ��  ��  � ��� i  � ���� I     ����
�� .Mth:NuHenull���     long� o      ���� 0 	thenumber 	theNumber� ����
�� 
Plac� |����������  ��  � o      ���� 0 padsize padSize��  � l     ������ m      ����  ��  ��  � �����
�� 
Pref� |����������  ��  � o      ���� 0 	hasprefix 	hasPrefix��  � l     ������ m      ��
�� boovtrue��  ��  ��  � l    ����� Q     ����� k    ��� ��� r    ��� n   ��� I    ������� (0 asintegerparameter asIntegerParameter� ��� o    	���� 0 	thenumber 	theNumber� ���� m   	 
�� ���  ��  ��  � o    ���� 0 _supportlib _supportLib� o      ���� 0 	thenumber 	theNumber� � � r     n    I    ������ (0 asintegerparameter asIntegerParameter  o    ���� 0 padsize padSize �� m    		 �

  p a d d i n g   t o��  ��   o    ���� 0 _supportlib _supportLib o      ���� 0 padsize padSize   r    , n   * I   $ *������ (0 asbooleanparameter asBooleanParameter  o   $ %���� 0 	hasprefix 	hasPrefix �� m   % & �  p r e f i x��  ��   o    $���� 0 _supportlib _supportLib o      ���� 0 	hasprefix 	hasPrefix  r   - 0 m   - . �   o      ���� 0 hextext hexText  Z   1 E ��! A   1 4"#" o   1 2���� 0 	thenumber 	theNumber# m   2 3����    k   7 ?$$ %&% r   7 :'(' m   7 8)) �**  -( o      ���� 0 	hexprefix 	hexPrefix& +��+ r   ; ?,-, d   ; =.. o   ; <���� 0 	thenumber 	theNumber- o      ���� 0 	thenumber 	theNumber��  ��  ! r   B E/0/ m   B C11 �22  0 o      ���� 0 	hexprefix 	hexPrefix 343 Z  F S56����5 o   F G���� 0 	hasprefix 	hasPrefix6 r   J O787 b   J M9:9 o   J K���� 0 	hexprefix 	hexPrefix: m   K L;; �<<  0 x8 o      ���� 0 	hexprefix 	hexPrefix��  ��  4 =>= V   T s?@? k   \ nAA BCB r   \ hDED b   \ fFGF l  \ dH����H n   \ dIJI 4   ] d��K
�� 
cobjK l  ^ cL����L [   ^ cMNM `   ^ aOPO o   ^ _���� 0 	thenumber 	theNumberP m   _ `���� N m   a b���� ��  ��  J m   \ ]QQ �RR   0 1 2 3 4 5 6 7 8 9 A B C D E F��  ��  G o   d e���� 0 hextext hexTextE o      ���� 0 hextext hexTextC S��S r   i nTUT _   i lVWV o   i j���� 0 	thenumber 	theNumberW m   j k���� U o      ���� 0 	thenumber 	theNumber��  @ ?   X [XYX o   X Y���� 0 	thenumber 	theNumberY m   Y Z����  > Z[Z V   t �\]\ r   ~ �^_^ b   ~ �`a` m   ~ bb �cc  0a o    ����� 0 hextext hexText_ o      ���� 0 hextext hexText] A   x }ded n   x {fgf 1   y {��
�� 
lengg o   x y���� 0 hextext hexTexte o   { |���� 0 padsize padSize[ h��h L   � �ii b   � �jkj o   � ����� 0 	hexprefix 	hexPrefixk o   � ����� 0 hextext hexText��  � R      ��lm
�� .ascrerr ****      � ****l o      ���� 0 etext eTextm �no
� 
errnn o      �~�~ 0 enumber eNumbero �}pq
�} 
erobp o      �|�| 0 efrom eFromq �{r�z
�{ 
errtr o      �y�y 
0 eto eTo�z  � I   � ��xs�w�x 
0 _error  s tut m   � �vv �ww 2 f o r m a t   h e x a d e c i m a l   n u m b e ru xyx o   � ��v�v 0 etext eTexty z{z o   � ��u�u 0 enumber eNumber{ |}| o   � ��t�t 0 efrom eFrom} ~�s~ o   � ��r�r 
0 eto eTo�s  �w  � � � TO DO: `padding to` is not an ideal name (OTOH, `using padding` sounds awkward, while `with padding` would likely cause confusion as standard `with`/`without` keywords may already be used with boolean `prefix` parameters)   � ��   T O   D O :   ` p a d d i n g   t o `   i s   n o t   a n   i d e a l   n a m e   ( O T O H ,   ` u s i n g   p a d d i n g `   s o u n d s   a w k w a r d ,   w h i l e   ` w i t h   p a d d i n g `   w o u l d   l i k e l y   c a u s e   c o n f u s i o n   a s   s t a n d a r d   ` w i t h ` / ` w i t h o u t `   k e y w o r d s   m a y   a l r e a d y   b e   u s e d   w i t h   b o o l e a n   ` p r e f i x `   p a r a m e t e r s )� ��� l     �q�p�o�q  �p  �o  � ��� l     �n�m�l�n  �m  �l  � ��� i  � ���� I     �k��
�k .Mth:HeNunull���     ctxt� o      �j�j 0 hextext hexText� �i��h
�i 
Prec� |�g�f��e��g  �f  � o      �d�d 0 	isprecise 	isPrecise�e  � l     ��c�b� m      �a
�a boovtrue�c  �b  �h  � Q    ���� P    ����� k    ��� ��� r    ��� n   ��� I    �`��_�` "0 astextparameter asTextParameter� ��� o    �^�^ 0 hextext hexText� ��]� m    �� ���  �]  �_  � o    �\�\ 0 _supportlib _supportLib� o      �[�[ 0 hextext hexText� ��� r    #��� n   !��� I    !�Z��Y�Z (0 asbooleanparameter asBooleanParameter� ��� o    �X�X 0 	isprecise 	isPrecise� ��W� m    �� ���  f u l l   p r e c i s i o n�W  �Y  � o    �V�V 0 _supportlib _supportLib� o      �U�U 0 	isprecise 	isPrecise� ��� Q   $ ����� k   ' ��� ��� r   ' *��� m   ' (�T�T  � o      �S�S 0 	thenumber 	theNumber� ��� r   + 0��� C   + .��� o   + ,�R�R 0 hextext hexText� m   , -�� ���  -� o      �Q�Q 0 
isnegative 
isNegative� ��� Z  1 F���P�O� o   1 2�N�N 0 
isnegative 
isNegative� r   5 B��� n   5 @��� 7  6 @�M��
�M 
ctxt� m   : <�L�L � m   = ?�K�K��� o   5 6�J�J 0 hextext hexText� o      �I�I 0 hextext hexText�P  �O  � ��� Z  G ^���H�G� C   G J��� o   G H�F�F 0 hextext hexText� m   H I�� ���  0 x� r   M Z��� n   M X��� 7  N X�E��
�E 
ctxt� m   R T�D�D � m   U W�C�C��� o   M N�B�B 0 hextext hexText� o      �A�A 0 hextext hexText�H  �G  � ��@� X   _ ���?�� k   o ��� ��� r   o t��� ]   o r��� o   o p�>�> 0 	thenumber 	theNumber� m   p q�=�= � o      �<�< 0 	thenumber 	theNumber� ��� r   u ���� I  u ���;�� z�:�9
�: .sysooffslong    ��� null
�9 misccura�;  � �8��
�8 
psof� o   { |�7�7 0 charref charRef� �6��5
�6 
psin� m   } ��� ���   0 1 2 3 4 5 6 7 8 9 A B C D E F�5  � o      �4�4 0 i  � ��� Z  � ����3�2� =   � ���� o   � ��1�1 0 i  � m   � ��0�0  � R   � ��/�.�-
�/ .ascrerr ****      � ****�.  �-  �3  �2  � ��,� r   � ���� \   � ���� [   � ���� o   � ��+�+ 0 	thenumber 	theNumber� o   � ��*�* 0 i  � m   � ��)�) � o      �(�( 0 	thenumber 	theNumber�,  �? 0 charref charRef� o   b c�'�' 0 hextext hexText�@  � R      �&�%�$
�& .ascrerr ****      � ****�%  �$  � R   � ��#��
�# .ascrerr ****      � ****� m   � ��� ��� > N o t   a   v a l i d   h e x a d e c i m a l   n u m b e r .� �"��
�" 
errn� m   � ��!�!�Y� � ��
�  
erob� o   � ��� 0 hextext hexText�  �    Z  � ��� F   � � o   � ��� 0 	isprecise 	isPrecise l  � ��� =   � � o   � ��� 0 	thenumber 	theNumber [   � �	
	 o   � ��� 0 	thenumber 	theNumber
 m   � ��� �  �   R   � ��
� .ascrerr ****      � **** m   � � � j H e x a d e c i m a l   n u m b e r   i s   t o o   l a r g e   t o   c o n v e r t   p r e c i s e l y . �
� 
errn m   � ����Y �
� 
erob o   � ��� 0 hextext hexText ��
� 
errt m   � ��
� 
doub�  �  �    Z  � ��� o   � ��� 0 
isnegative 
isNegative r   � � d   � � o   � ��
�
 0 	thenumber 	theNumber o      �	�	 0 	thenumber 	theNumber�  �   � L   � � o   � ��� 0 	thenumber 	theNumber�  � �
� consdiac �
� conshyph �
� conspunc ��
� conswhit�  � � 
� conscase  � ��
�  consnume��  � R      ��!"
�� .ascrerr ****      � ****! o      ���� 0 etext eText" ��#$
�� 
errn# o      ���� 0 enumber eNumber$ ��%&
�� 
erob% o      ���� 0 efrom eFrom& ��'��
�� 
errt' o      ���� 
0 eto eTo��  � I  ��(���� 
0 _error  ( )*) m  	++ �,, 0 p a r s e   h e x a d e c i m a l   n u m b e r* -.- o  	
���� 0 etext eText. /0/ o  
���� 0 enumber eNumber0 121 o  ���� 0 efrom eFrom2 3��3 o  ���� 
0 eto eTo��  ��  � 454 l     ��������  ��  ��  5 676 l     ��������  ��  ��  7 898 l     ��:;��  : J D--------------------------------------------------------------------   ; �<< � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -9 =>= l     ��?@��  ? !  General numeric operations   @ �AA 6   G e n e r a l   n u m e r i c   o p e r a t i o n s> BCB l     ��������  ��  ��  C DED i  � �FGF I     ��H��
�� .Mth:DeRanull���     doubH o      ���� 0 n  ��  G Q     IJKI L    LL ]    
MNM l   O����O c    PQP o    ���� 0 n  Q m    ��
�� 
doub��  ��  N l   	R����R ^    	STS 1    ��
�� 
pi  T m    ���� ���  ��  J R      ��UV
�� .ascrerr ****      � ****U o      ���� 0 etext eTextV ��WX
�� 
errnW o      ���� 0 enumber eNumberX ��YZ
�� 
erobY o      ���� 0 efrom eFromZ ��[��
�� 
errt[ o      ���� 
0 eto eTo��  K I    ��\���� 
0 _error  \ ]^] m    __ �`` $ c o n v e r t   t o   r a d i a n s^ aba o    ���� 0 etext eTextb cdc o    ���� 0 enumber eNumberd efe o    ���� 0 efrom eFromf g��g o    ���� 
0 eto eTo��  ��  E hih l     ��������  ��  ��  i jkj l     ��������  ��  ��  k lml i  � �non I     ��p��
�� .Mth:RaDenull���     doubp o      ���� 0 n  ��  o Q     qrsq L    	tt ^    uvu o    ���� 0 n  v l   w����w ^    xyx 1    ��
�� 
pi  y m    ���� ���  ��  r R      ��z{
�� .ascrerr ****      � ****z o      ���� 0 etext eText{ ��|}
�� 
errn| o      ���� 0 enumber eNumber} ��~
�� 
erob~ o      ���� 0 efrom eFrom �����
�� 
errt� o      ���� 
0 eto eTo��  s I    ������� 
0 _error  � ��� m    �� ��� $ c o n v e r t   t o   d e g r e e s� ��� o    ���� 0 etext eText� ��� o    ���� 0 enumber eNumber� ��� o    ���� 0 efrom eFrom� ���� o    ���� 
0 eto eTo��  ��  m ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  � ���� I     �����
�� .Mth:Abs_null���     nmbr� o      ���� 0 n  ��  � Q     )���� k    �� ��� r    ��� c    ��� o    ���� 0 n  � m    ��
�� 
nmbr� o      ���� 0 n  � ���� Z   	 ������ A   	 ��� o   	 
���� 0 n  � m   
 ����  � L    �� d    �� o    ���� 0 n  ��  � L    �� o    ���� 0 n  ��  � R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  � I    )������� 
0 _error  � ��� m     !�� ���  a b s� ��� o   ! "���� 0 etext eText� ��� o   " #���� 0 enumber eNumber� ��� o   # $���� 0 efrom eFrom� ���� o   $ %���� 
0 eto eTo��  ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  � ���� I     ���~
� .Mth:CmpNnull���     ****� J      �� ��� o      �}�} 0 n1  � ��|� o      �{�{ 0 n2  �|  �~  � Q     Y���� k    G�� ��� r    ��� J    �� ��� c    ��� o    �z�z 0 n1  � m    �y
�y 
doub� ��x� c    	��� o    �w�w 0 n2  � m    �v
�v 
doub�x  � J      �� ��� o      �u�u 0 n1  � ��t� o      �s�s 0 n2  �t  � ��r� Z    G����� F    2��� l   $��q�p� A    $��� \    "��� o    �o�o 0 n1  � o    !�n�n 0 _isequaldelta _isEqualDelta� o   " #�m�m 0 n2  �q  �p  � l  ' 0��l�k� ?   ' 0��� [   ' .��� o   ' (�j�j 0 n1  � o   ( -�i�i 0 _isequaldelta _isEqualDelta� o   . /�h�h 0 n2  �l  �k  � L   5 7�� m   5 6�g�g  � ��� A   : =��� o   : ;�f�f 0 n1  � o   ; <�e�e 0 n2  � ��d� L   @ B�� m   @ A�c�c���d  � L   E G�� m   E F�b�b �r  � R      �a��
�a .ascrerr ****      � ****� o      �`�` 0 etext eText� �_��
�_ 
errn� o      �^�^ 0 enumber eNumber� �]��
�] 
erob� o      �\�\ 0 efrom eFrom� �[��Z
�[ 
errt� o      �Y�Y 
0 eto eTo�Z  � I   O Y�X��W�X 
0 _error  �    m   P Q �  c m p  o   Q R�V�V 0 etext eText  o   R S�U�U 0 enumber eNumber 	 o   S T�T�T 0 efrom eFrom	 
�S
 o   T U�R�R 
0 eto eTo�S  �W  �  l     �Q�P�O�Q  �P  �O    l     �N�M�L�N  �M  �L    i  � � I     �K�J
�K .Mth:MinNnull���     **** o      �I�I 0 thelist theList�J   Q     Y k    G  r     n    I    �H�G�H "0 aslistparameter asListParameter   o    	�F�F 0 thelist theList  !�E! m   	 
"" �##  �E  �G   o    �D�D 0 _supportlib _supportLib o      �C�C 0 thelist theList $%$ r    &'& c    ()( l   *�B�A* n    +,+ 4   �@-
�@ 
cobj- m    �?�? , o    �>�> 0 thelist theList�B  �A  ) m    �=
�= 
nmbr' o      �<�< 0 	theresult 	theResult% ./. X    D0�;10 k   * ?22 343 r   * 1565 c   * /787 n  * -9:9 1   + -�:
�: 
pcnt: o   * +�9�9 0 aref aRef8 m   - .�8
�8 
nmbr6 o      �7�7 0 n  4 ;�6; Z  2 ?<=�5�4< A   2 5>?> o   2 3�3�3 0 n  ? o   3 4�2�2 0 	theresult 	theResult= r   8 ;@A@ o   8 9�1�1 0 n  A o      �0�0 0 	theresult 	theResult�5  �4  �6  �; 0 aref aRef1 o    �/�/ 0 thelist theList/ B�.B L   E GCC o   E F�-�- 0 	theresult 	theResult�.   R      �,DE
�, .ascrerr ****      � ****D o      �+�+ 0 etext eTextE �*FG
�* 
errnF o      �)�) 0 enumber eNumberG �(HI
�( 
erobH o      �'�' 0 efrom eFromI �&J�%
�& 
errtJ o      �$�$ 
0 eto eTo�%   I   O Y�#K�"�# 
0 _error  K LML m   P QNN �OO  m i nM PQP o   Q R�!�! 0 etext eTextQ RSR o   R S� �  0 enumber eNumberS TUT o   S T�� 0 efrom eFromU V�V o   T U�� 
0 eto eTo�  �"   WXW l     ����  �  �  X YZY l     ����  �  �  Z [\[ i  � �]^] I     �_�
� .Mth:MaxNnull���     ****_ o      �� 0 thelist theList�  ^ Q     Y`ab` k    Gcc ded r    fgf n   hih I    �j�� "0 aslistparameter asListParameterj klk o    	�� 0 thelist theListl m�m m   	 
nn �oo  �  �  i o    �� 0 _supportlib _supportLibg o      �� 0 thelist theListe pqp r    rsr c    tut l   v��v n    wxw 4   �y
� 
cobjy m    �
�
 x o    �	�	 0 thelist theList�  �  u m    �
� 
nmbrs o      �� 0 	theresult 	theResultq z{z X    D|�}| k   * ?~~ � r   * 1��� c   * /��� n  * -��� 1   + -�
� 
pcnt� o   * +�� 0 aref aRef� m   - .�
� 
nmbr� o      �� 0 n  � ��� Z  2 ?��� ��� ?   2 5��� o   2 3���� 0 n  � o   3 4���� 0 	theresult 	theResult� r   8 ;��� o   8 9���� 0 n  � o      ���� 0 	theresult 	theResult�   ��  �  � 0 aref aRef} o    ���� 0 thelist theList{ ���� L   E G�� o   E F���� 0 	theresult 	theResult��  a R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  b I   O Y������� 
0 _error  � ��� m   P Q�� ���  m a x� ��� o   Q R���� 0 etext eText� ��� o   R S���� 0 enumber eNumber� ��� o   S T���� 0 efrom eFrom� ���� o   T U���� 
0 eto eTo��  ��  \ ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  � ���� I     ����
�� .Mth:RouNnull���     doub� o      ���� 0 num  � ����
�� 
Plac� |����������  ��  � o      ���� 0 decimalplaces decimalPlaces��  � l     ������ m      ����  ��  ��  � �����
�� 
Dire� |����������  ��  � o      ���� &0 roundingdirection roundingDirection��  � l     ������ m      ��
�� MRndRNhE��  ��  ��  � k    C�� ��� l     ������  � � � TO DO: implement `rounding halves toward zero` and `rounding away from zero` for complete consistency with NSNumberFormatterRoundingMode (which is used by `format number`)   � ���X   T O   D O :   i m p l e m e n t   ` r o u n d i n g   h a l v e s   t o w a r d   z e r o `   a n d   ` r o u n d i n g   a w a y   f r o m   z e r o `   f o r   c o m p l e t e   c o n s i s t e n c y   w i t h   N S N u m b e r F o r m a t t e r R o u n d i n g M o d e   ( w h i c h   i s   u s e d   b y   ` f o r m a t   n u m b e r ` )� ���� Q    C���� k   -�� ��� r    ��� n   ��� I    ������� "0 asrealparameter asRealParameter� ��� o    	���� 0 num  � ���� m   	 
�� ���  ��  ��  � o    ���� 0 _supportlib _supportLib� o      ���� 0 num  � ��� r    ��� n   ��� I    ������� (0 asintegerparameter asIntegerParameter� ��� o    ���� 0 decimalplaces decimalPlaces� ���� m    �� ���  t o   p l a c e s��  ��  � o    ���� 0 _supportlib _supportLib� o      ���� 0 decimalplaces decimalPlaces� ��� Z    8������� >    "��� o     ���� 0 decimalplaces decimalPlaces� m     !����  � k   % 4�� ��� r   % *��� a   % (��� m   % &���� 
� o   & '���� 0 decimalplaces decimalPlaces� o      ���� 0 themultiplier theMultiplier� ���� l  + 4���� r   + 4��� ^   + 2��� ]   + 0��� ]   + .��� o   + ,���� 0 num  � m   , -���� 
� o   . /���� 0 themultiplier theMultiplier� m   0 1���� 
� o      ���� 0 num  ��� multiplying and dividing by 10 before and after applying the multiplier helps avoid poor rounding results for some numbers due to inevitable loss of precision in floating-point math (e.g. `324.21 * 100 div 1 / 100` returns 324.2 but needs to be 324.21), though this hasn't been tested on all possible values for obvious reasons -- TO DO: shouldn't /10 be done after rounding is applied (in which case following calculations should use mod 10, etc)?   � ����   m u l t i p l y i n g   a n d   d i v i d i n g   b y   1 0   b e f o r e   a n d   a f t e r   a p p l y i n g   t h e   m u l t i p l i e r   h e l p s   a v o i d   p o o r   r o u n d i n g   r e s u l t s   f o r   s o m e   n u m b e r s   d u e   t o   i n e v i t a b l e   l o s s   o f   p r e c i s i o n   i n   f l o a t i n g - p o i n t   m a t h   ( e . g .   ` 3 2 4 . 2 1   *   1 0 0   d i v   1   /   1 0 0 `   r e t u r n s   3 2 4 . 2   b u t   n e e d s   t o   b e   3 2 4 . 2 1 ) ,   t h o u g h   t h i s   h a s n ' t   b e e n   t e s t e d   o n   a l l   p o s s i b l e   v a l u e s   f o r   o b v i o u s   r e a s o n s   - -   T O   D O :   s h o u l d n ' t   / 1 0   b e   d o n e   a f t e r   r o u n d i n g   i s   a p p l i e d   ( i n   w h i c h   c a s e   f o l l o w i n g   c a l c u l a t i o n s   s h o u l d   u s e   m o d   1 0 ,   e t c ) ?��  ��  ��  � ��� l  9 9������  � � � TO DO: check the following real comparisons work reliably and won't fall afoul of floating point imprecisions (might be an idea to use `cmp` or similar to allow for that; eliminating current magic math would also make this code easier to verify)   � ����   T O   D O :   c h e c k   t h e   f o l l o w i n g   r e a l   c o m p a r i s o n s   w o r k   r e l i a b l y   a n d   w o n ' t   f a l l   a f o u l   o f   f l o a t i n g   p o i n t   i m p r e c i s i o n s   ( m i g h t   b e   a n   i d e a   t o   u s e   ` c m p `   o r   s i m i l a r   t o   a l l o w   f o r   t h a t ;   e l i m i n a t i n g   c u r r e n t   m a g i c   m a t h   w o u l d   a l s o   m a k e   t h i s   c o d e   e a s i e r   t o   v e r i f y )� ��� Z   9����� =  9 <��� o   9 :���� &0 roundingdirection roundingDirection� l  : ; ����  m   : ;��
�� MRndRNhE��  ��  � Z   ? m E  ? K J   ? C 	 m   ? @

 ��      	 �� m   @ A ?�      ��   J   C J �� `   C H l  C F���� ^   C F o   C D���� 0 num   m   D E���� ��  ��   m   F G���� ��   l  N S r   N S _   N Q o   N O���� 0 num   m   O P����  o      ���� 0 num   T N if num ends in .5 and its div is even then round toward zero so it stays even    � �   i f   n u m   e n d s   i n   . 5   a n d   i t s   d i v   i s   e v e n   t h e n   r o u n d   t o w a r d   z e r o   s o   i t   s t a y s   e v e n  ?   V Y o   V W���� 0 num   m   W X����    ��  l  \ c!"#! r   \ c$%$ _   \ a&'& l  \ _(����( [   \ _)*) o   \ ]���� 0 num  * m   ] ^++ ?�      ��  ��  ' m   _ `���� % o      ���� 0 num  " H B else round to nearest whole digit (.5 will round up if positive�)   # �,, �   e l s e   r o u n d   t o   n e a r e s t   w h o l e   d i g i t   ( . 5   w i l l   r o u n d   u p   i f   p o s i t i v e & )��   l  f m-./- r   f m010 _   f k232 l  f i4����4 \   f i565 o   f g���� 0 num  6 m   g h77 ?�      ��  ��  3 m   i j���� 1 o      ���� 0 num  . 4 . (�or down if negative to give an even result)   / �88 \   ( & o r   d o w n   i f   n e g a t i v e   t o   g i v e   a n   e v e n   r e s u l t )� 9:9 =  p s;<; o   p q���� &0 roundingdirection roundingDirection< l  q r=����= m   q r��
�� MRndRNhT��  ��  : >?> Z   v �@ABC@ E  v �DED J   v zFF GHG m   v wII ��      H J��J m   w xKK ?�      ��  E J   z LL M��M `   z }NON o   z {���� 0 num  O m   { |���� ��  A l  � �PQRP r   � �STS _   � �UVU o   � ����� 0 num  V m   � ����� T o      ���� 0 num  Q 0 * if num ends in .5 then round towards zero   R �WW T   i f   n u m   e n d s   i n   . 5   t h e n   r o u n d   t o w a r d s   z e r oB XYX ?   � �Z[Z o   � ����� 0 num  [ m   � �����  Y \��\ l  � �]^_] r   � �`a` _   � �bcb l  � �d����d [   � �efe o   � ����� 0 num  f m   � �gg ?�      ��  ��  c m   � ����� a o      ���� 0 num  ^ ( " else round to nearest whole digit   _ �hh D   e l s e   r o u n d   t o   n e a r e s t   w h o l e   d i g i t��  C r   � �iji _   � �klk l  � �m����m \   � �non o   � ����� 0 num  o m   � �pp ?�      ��  ��  l m   � ����� j o      ���� 0 num  ? qrq =  � �sts o   � ��� &0 roundingdirection roundingDirectiont l  � �u�~�}u m   � ��|
�| MRndRN_T�~  �}  r vwv r   � �xyx _   � �z{z o   � ��{�{ 0 num  { m   � ��z�z y o      �y�y 0 num  w |}| =  � �~~ o   � ��x�x &0 roundingdirection roundingDirection l  � ���w�v� m   � ��u
�u MRndRN_U�w  �v  } ��� Z   � ����t�� G   � ���� A   � ���� o   � ��s�s 0 num  � m   � ��r�r  � =   � ���� `   � ���� o   � ��q�q 0 num  � m   � ��p�p � m   � ��o�o  � r   � ���� _   � ���� o   � ��n�n 0 num  � m   � ��m�m � o      �l�l 0 num  �t  � r   � ���� _   � ���� l  � ���k�j� [   � ���� o   � ��i�i 0 num  � m   � ��h�h �k  �j  � m   � ��g�g � o      �f�f 0 num  � ��� =  � ���� o   � ��e�e &0 roundingdirection roundingDirection� l  � ���d�c� m   � ��b
�b MRndRN_D�d  �c  � ��a� Z   � ���`�� G   � ���� ?   � ���� o   � ��_�_ 0 num  � m   � ��^�^  � =   � ���� `   � ���� o   � ��]�] 0 num  � m   � ��\�\ � m   � ��[�[  � r   � ���� _   � ���� o   � ��Z�Z 0 num  � m   � ��Y�Y � o      �X�X 0 num  �`  � r   � ��� _   � ���� l  � ���W�V� \   � ���� o   � ��U�U 0 num  � m   � ��T�T �W  �V  � m   � ��S�S � o      �R�R 0 num  �a  � n ��� I  �Q��P�Q >0 throwinvalidparameterconstant throwInvalidParameterConstant� ��� o  	�O�O &0 roundingdirection roundingDirection� ��N� m  	
�� ���  b y�N  �P  � o  �M�M 0 _supportlib _supportLib� ��L� Z  -����� =  ��� o  �K�K 0 decimalplaces decimalPlaces� m  �J�J  � L  �� _  ��� o  �I�I 0 num  � m  �H�H � ��� A  ��� o  �G�G 0 decimalplaces decimalPlaces� m  �F�F  � ��E� L  "&�� _  "%��� o  "#�D�D 0 num  � o  #$�C�C 0 themultiplier theMultiplier�E  � L  )-�� ^  ),��� o  )*�B�B 0 num  � o  *+�A�A 0 themultiplier theMultiplier�L  � R      �@��
�@ .ascrerr ****      � ****� o      �?�? 0 etext eText� �>��
�> 
errn� o      �=�= 0 enumber eNumber� �<��
�< 
erob� o      �;�; 0 efrom eFrom� �:��9
�: 
errt� o      �8�8 
0 eto eTo�9  � I  5C�7��6�7 
0 _error  � ��� m  69�� ���  r o u n d   n u m b e r� ��� o  9:�5�5 0 etext eText� ��� o  :;�4�4 0 enumber eNumber� ��� o  ;<�3�3 0 efrom eFrom� ��2� o  <=�1�1 
0 eto eTo�2  �6  ��  � ��� l     �0�/�.�0  �/  �.  � ��� l     �-�,�+�-  �,  �+  � ��� l     �*���*  � J D--------------------------------------------------------------------   � ��� � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -� ��� l     �)���)  �   Trigonometry   � ���    T r i g o n o m e t r y� ��� l     �(�'�&�(  �'  �&  � ��� i  � ���� I      �%��$�% 0 _sin  � ��#� o      �"�" 0 x  �#  �$  � k    �� ��� Z     +���!� � =       `      o     �� 0 x   m    ��  m    ��  � l   ' k    ' 	 Z   
��
 A     o    	�� 0 x   m   	 
��   r     d     o    �� 0 x   o      �� 0 x  �  �  	 � L    ' n   & 4    %�
� 
cobj l   $�� [    $ _    " `      o    �� 0 x   m    ��h m     !��  m   " #�� �  �   o    �� 0 _precalcsine _precalcSine�   1 + performance optimisation for common values    � V   p e r f o r m a n c e   o p t i m i s a t i o n   f o r   c o m m o n   v a l u e s�!  �   �  l  , 5 !"  r   , 5#$# ^   , 3%&% ]   , 1'(' `   , /)*) o   , -�� 0 x  * m   - .��h( 1   / 0�
� 
pi  & m   1 2�
�
 �$ o      �	�	 0 x  ! &   convert from degrees to radians   " �++ @   c o n v e r t   f r o m   d e g r e e s   t o   r a d i a n s ,-, r   6 ;./. A   6 9010 o   6 7�� 0 x  1 m   7 8��  / o      �� 0 isneg isNeg- 232 Z  < H45��4 o   < =�� 0 isneg isNeg5 r   @ D676 d   @ B88 o   @ A�� 0 x  7 o      �� 0 x  �  �  3 9:9 r   I R;<; _   I P=>= l  I N?� ��? ]   I N@A@ o   I J���� 0 x  A l  J MB����B ^   J MCDC m   J K���� D 1   K L��
�� 
pi  ��  ��  �   ��  > m   N O���� < o      ���� 0 y  : EFE r   S ^GHG \   S \IJI o   S T���� 0 y  J ]   T [KLK l  T YM����M _   T YNON ]   T WPQP o   T U���� 0 y  Q m   U VRR ?�      O m   W X���� ��  ��  L m   Y Z���� H o      ���� 0 z  F STS Z   _ vUV����U =  _ dWXW `   _ bYZY o   _ `���� 0 z  Z m   ` a���� X m   b c���� V k   g r[[ \]\ r   g l^_^ [   g j`a` o   g h���� 0 z  a m   h i���� _ o      ���� 0 z  ] b��b r   m rcdc [   m pefe o   m n���� 0 y  f m   n o���� d o      ���� 0 y  ��  ��  ��  T ghg r   w |iji `   w zklk o   w x���� 0 z  l m   x y���� j o      ���� 0 z  h mnm Z   } �op����o ?   } �qrq o   } ~���� 0 z  r m   ~ ���� p k   � �ss tut r   � �vwv H   � �xx o   � ����� 0 isneg isNegw o      ���� 0 isneg isNegu y��y r   � �z{z \   � �|}| o   � ����� 0 z  } m   � ����� { o      ���� 0 z  ��  ��  ��  n ~~ r   � ���� \   � ���� l  � ������� \   � ���� l  � ������� \   � ���� o   � ����� 0 x  � ]   � ���� o   � ����� 0 y  � m   � ��� ?�!�?��v��  ��  � ]   � ���� o   � ����� 0 y  � m   � ��� >dD,���J��  ��  � ]   � ���� o   � ����� 0 y  � m   � ��� <�F���P�� o      ���� 0 z2   ��� r   � ���� ]   � ���� o   � ����� 0 z2  � o   � ����� 0 z2  � o      ���� 0 zz  � ��� Z   ������� G   � ���� =  � ���� o   � ����� 0 z  � m   � ����� � =  � ���� o   � ����� 0 z  � m   � ����� � r   � ���� [   � ���� \   � ���� m   � ��� ?�      � ^   � ���� o   � ����� 0 zz  � m   � ����� � ]   � ���� ]   � ���� o   � ����� 0 zz  � o   � ����� 0 zz  � l  � ������� [   � ���� ]   � ���� l  � ������� \   � ���� ]   � ���� l  � ������� [   � ���� ]   � ���� l  � ������� \   � ���� ]   � ���� l  � ������� [   � ���� ]   � ���� m   � ��� ���I���� o   � ����� 0 zz  � m   � ��� >!�{N>���  ��  � o   � ����� 0 zz  � m   � ��� >�~O~�K���  ��  � o   � ����� 0 zz  � m   � ��� >���D���  ��  � o   � ����� 0 zz  � m   � ��� ?V�l�=���  ��  � o   � ����� 0 zz  � m   � ��� ?�UUUV���  ��  � o      ���� 0 y  ��  � r   ���� [   �	��� o   � ����� 0 z2  � ]   ���� ]   � ���� o   � ����� 0 z2  � o   � ����� 0 zz  � l  ������� \   ���� ]   ���� l  ������� [   ���� ]   � ���� l  � ������� \   � ���� ]   � ���� l  � ������� [   � ���� ]   � ���� l  � ������� \   � ���� ]   � ���� m   � ��� =���ќ�� o   � ����� 0 zz  � m   � ��� >Z��)[��  ��  � o   � ����� 0 zz  � m   � ��� >��V}H���  ��  � o   � ����� 0 zz  � m   � ��� ?*������  ��  � o   � ����� 0 zz  � m   � �� ?�"w��  ��  � o  ���� 0 zz  � m  �� ?�UUUU�?��  ��  � o      ���� 0 y  � ��� Z ������� o  ���� 0 isneg isNeg� r  ��� d  �� o  ���� 0 y  � o      ���� 0 y  ��  ��  � ���� L  �� o  ���� 0 y  ��  � 	 		  l     ��������  ��  ��  	 			 l     ��������  ��  ��  	 			 l     ��������  ��  ��  	 			 i  � �				 I     ��	
��
�� .Mth:Sin_null���     doub	
 o      ���� 0 n  ��  		 Q     				 L    		 I    ��	���� 0 _sin  	 	��	 c    			 o    ���� 0 x  	 m    ��
�� 
nmbr��  ��  	 R      ��		
�� .ascrerr ****      � ****	 o      ���� 0 etext eText	 ��		
�� 
errn	 o      ���� 0 enumber eNumber	 ��		
�� 
erob	 o      ���� 0 efrom eFrom	 ��	��
�� 
errt	 o      �� 
0 eto eTo��  	 I    �~	�}�~ 
0 _error  	 			 m    		 �		  s i n	 		 	 o    �|�| 0 etext eText	  	!	"	! o    �{�{ 0 enumber eNumber	" 	#	$	# o    �z�z 0 efrom eFrom	$ 	%�y	% o    �x�x 
0 eto eTo�y  �}  	 	&	'	& l     �w�v�u�w  �v  �u  	' 	(	)	( l     �t�s�r�t  �s  �r  	) 	*	+	* i  � �	,	-	, I     �q	.�p
�q .Mth:Cos_null���     doub	. o      �o�o 0 n  �p  	- Q      	/	0	1	/ L    	2	2 I    �n	3�m�n 0 _sin  	3 	4�l	4 [    		5	6	5 l   	7�k�j	7 c    	8	9	8 o    �i�i 0 n  	9 m    �h
�h 
nmbr�k  �j  	6 m    �g�g Z�l  �m  	0 R      �f	:	;
�f .ascrerr ****      � ****	: o      �e�e 0 etext eText	; �d	<	=
�d 
errn	< o      �c�c 0 enumber eNumber	= �b	>	?
�b 
erob	> o      �a�a 0 efrom eFrom	? �`	@�_
�` 
errt	@ o      �^�^ 
0 eto eTo�_  	1 I     �]	A�\�] 
0 _error  	A 	B	C	B m    	D	D �	E	E  c o s	C 	F	G	F o    �[�[ 0 etext eText	G 	H	I	H o    �Z�Z 0 enumber eNumber	I 	J	K	J o    �Y�Y 0 efrom eFrom	K 	L�X	L o    �W�W 
0 eto eTo�X  �\  	+ 	M	N	M l     �V�U�T�V  �U  �T  	N 	O	P	O l     �S�R�Q�S  �R  �Q  	P 	Q	R	Q i  � �	S	T	S I     �P	U�O
�P .Mth:Tan_null���     doub	U o      �N�N 0 n  �O  	T Q    4	V	W	X	V k   	Y	Y 	Z	[	Z r    	\	]	\ c    	^	_	^ o    �M�M 0 n  	_ m    �L
�L 
nmbr	] o      �K�K 0 x  	[ 	`	a	` Z   	 O	b	c�J�I	b =  	 	d	e	d `   	 	f	g	f o   	 
�H�H 0 x  	g m   
 �G�G 	e m    �F�F  	c l   K	h	i	j	h k    K	k	k 	l	m	l Z   	n	o�E�D	n A    	p	q	p o    �C�C 0 x  	q m    �B�B  	o r    	r	s	r d    	t	t o    �A�A 0 x  	s o      �@�@ 0 x  �E  �D  	m 	u	v	u Z    :	w	x�?�>	w G     +	y	z	y =    #	{	|	{ o     !�=�= 0 x  	| m   ! "�<�< Z	z =  & )	}	~	} o   & '�;�; 0 x  	~ m   ' (�:�:	x R   . 6�9		�
�9 .ascrerr ****      � ****	 m   4 5	�	� �	�	� F I n v a l i d   n u m b e r   ( r e s u l t   w o u l d   b e  " ) .	� �8	�	�
�8 
errn	� m   0 1�7�7�Y	� �6	��5
�6 
erob	� o   2 3�4�4 0 x  �5  �?  �>  	v 	��3	� L   ; K	�	� n  ; J	�	�	� 4   @ I�2	�
�2 
cobj	� l  A H	��1�0	� [   A H	�	�	� _   A F	�	�	� `   A D	�	�	� o   A B�/�/ 0 x  	� m   B C�.�.h	� m   D E�-�- 	� m   F G�,�, �1  �0  	� o   ; @�+�+ "0 _precalctangent _precalcTangent�3  	i 1 + performance optimisation for common values   	j �	�	� V   p e r f o r m a n c e   o p t i m i s a t i o n   f o r   c o m m o n   v a l u e s�J  �I  	a 	�	�	� l  P Y	�	�	�	� r   P Y	�	�	� ^   P W	�	�	� ]   P U	�	�	� `   P S	�	�	� o   P Q�*�* 0 x  	� m   Q R�)�)h	� 1   S T�(
�( 
pi  	� m   U V�'�' �	� o      �&�& 0 x  	� &   convert from degrees to radians   	� �	�	� @   c o n v e r t   f r o m   d e g r e e s   t o   r a d i a n s	� 	�	�	� r   Z _	�	�	� A   Z ]	�	�	� o   Z [�%�% 0 x  	� m   [ \�$�$  	� o      �#�# 0 isneg isNeg	� 	�	�	� Z  ` l	�	��"�!	� o   ` a� �  0 isneg isNeg	� r   d h	�	�	� d   d f	�	� o   d e�� 0 x  	� o      �� 0 x  �"  �!  	� 	�	�	� r   m v	�	�	� _   m t	�	�	� l  m r	���	� ^   m r	�	�	� o   m n�� 0 x  	� l  n q	���	� ^   n q	�	�	� 1   n o�
� 
pi  	� m   o p�� �  �  �  �  	� m   r s�� 	� o      �� 0 y  	� 	�	�	� r   w �	�	�	� \   w �	�	�	� o   w x�� 0 y  	� ]   x 	�	�	� l  x }	���	� _   x }	�	�	� ]   x {	�	�	� o   x y�� 0 y  	� m   y z	�	� ?�      	� m   { |�� �  �  	� m   } ~�� 	� o      �� 0 z  	� 	�	�	� Z   � �	�	���	� =  � �	�	�	� `   � �	�	�	� o   � ��� 0 z  	� m   � ��
�
 	� m   � ��	�	 	� k   � �	�	� 	�	�	� r   � �	�	�	� [   � �	�	�	� o   � ��� 0 z  	� m   � ��� 	� o      �� 0 z  	� 	��	� r   � �	�	�	� [   � �	�	�	� o   � ��� 0 y  	� m   � ��� 	� o      �� 0 y  �  �  �  	� 	�	�	� r   � �	�	�	� \   � �	�	�	� l  � �	��� 	� \   � �	�	�	� l  � �	�����	� \   � �	�	�	� o   � ����� 0 x  	� ]   � �	�	�	� o   � ����� 0 y  	� m   � �	�	� ?�!�P M��  ��  	� ]   � �	�	�	� o   � ����� 0 y  	� m   � �	�	� >A�`  �  �   	� ]   � �	�	�	� o   � ����� 0 y  	� m   � �	�	� <��&3\	� o      ���� 0 z2  	� 	�	�	� r   � �	�	�	� ]   � �	�	�	� o   � ����� 0 z2  	� o   � ����� 0 z2  	� o      ���� 0 zz  	� 	�	�	� Z   � �	�	���	�	� ?   � �	�	�	� o   � ����� 0 zz  	� m   � �	�	� =����+�	� r   � �	�
 	� [   � �


 o   � ����� 0 z2  
 ^   � �


 ]   � �


 ]   � �


 o   � ����� 0 z2  
 o   � ����� 0 zz  
 l  � �
	����
	 \   � �




 ]   � �


 l  � �
����
 [   � �


 ]   � �


 m   � �

 �ɒ��O?D
 o   � ����� 0 zz  
 m   � �

 A1�������  ��  
 o   � ����� 0 zz  
 m   � �

 Aq��)�y��  ��  
 l  � �
����
 \   � �


 ]   � �


 l  � �
����
 [   � �


 ]   � �


 l  � �
 ����
  \   � �
!
"
! ]   � �
#
$
# l  � �
%����
% [   � �
&
'
& o   � ����� 0 zz  
' m   � �
(
( @ʸ��et��  ��  
$ o   � ����� 0 zz  
" m   � �
)
) A4'�X*����  ��  
 o   � ����� 0 zz  
 m   � �
*
* Awُ������  ��  
 o   � ����� 0 zz  
 m   � �
+
+ A���<�Z6��  ��  
  o      ���� 0 y  ��  	� r   � �
,
-
, o   � ����� 0 z2  
- o      ���� 0 y  	� 
.
/
. Z  �
0
1����
0 G   �
2
3
2 =  � �
4
5
4 o   � ����� 0 z  
5 m   � ����� 
3 =  � 
6
7
6 o   � ����� 0 z  
7 m   � ����� 
1 r  

8
9
8 ^  
:
;
: m  ������
; o  ���� 0 y  
9 o      ���� 0 y  ��  ��  
/ 
<
=
< Z 
>
?����
> o  ���� 0 isneg isNeg
? r  
@
A
@ d  
B
B o  ���� 0 y  
A o      ���� 0 y  ��  ��  
= 
C��
C L  
D
D o  ���� 0 y  ��  	W R      ��
E
F
�� .ascrerr ****      � ****
E o      ���� 0 etext eText
F ��
G
H
�� 
errn
G o      ���� 0 enumber eNumber
H ��
I
J
�� 
erob
I o      ���� 0 efrom eFrom
J ��
K��
�� 
errt
K o      ���� 
0 eto eTo��  	X I  &4��
L���� 
0 _error  
L 
M
N
M m  '*
O
O �
P
P  t a n
N 
Q
R
Q o  *+���� 0 etext eText
R 
S
T
S o  +,���� 0 enumber eNumber
T 
U
V
U o  ,-���� 0 efrom eFrom
V 
W��
W o  -.���� 
0 eto eTo��  ��  	R 
X
Y
X l     ��������  ��  ��  
Y 
Z
[
Z l     ��������  ��  ��  
[ 
\
]
\ l     ��
^
_��  
^  -----   
_ �
`
` 
 - - - - -
] 
a
b
a l     ��
c
d��  
c   inverse   
d �
e
e    i n v e r s e
b 
f
g
f l     ��������  ��  ��  
g 
h
i
h i  � �
j
k
j I      ��
l���� 	0 _asin  
l 
m��
m o      ���� 0 n  ��  ��  
k k     �
n
n 
o
p
o r     
q
r
q A     
s
t
s o     ���� 0 x  
t m    ����  
r o      ���� 0 isneg isNeg
p 
u
v
u Z   
w
x����
w o    ���� 0 isneg isNeg
x r   
 
y
z
y d   
 
{
{ o   
 ���� 0 x  
z o      ���� 0 x  ��  ��  
v 
|
}
| Z   %
~
����
~ ?    
�
�
� o    ���� 0 x  
� m    ���� 
 R    !��
�
�
�� .ascrerr ****      � ****
� m     
�
� �
�
� T I n v a l i d   n u m b e r   ( n o t   b e t w e e n   - 1 . 0   a n d   1 . 0 ) .
� ��
�
�
�� 
errn
� m    �����Y
� ��
���
�� 
erob
� o    ���� 0 x  ��  ��  ��  
} 
�
�
� Z   & �
�
�
�
�
� ?   & )
�
�
� o   & '���� 0 x  
� m   ' (
�
� ?�      
� k   , 
�
� 
�
�
� r   , 1
�
�
� \   , /
�
�
� m   , -���� 
� o   - .���� 0 x  
� o      ���� 0 zz  
� 
�
�
� r   2 W
�
�
� ^   2 U
�
�
� ]   2 E
�
�
� o   2 3���� 0 zz  
� l  3 D
�����
� [   3 D
�
�
� ]   3 B
�
�
� l  3 @
�����
� \   3 @
�
�
� ]   3 >
�
�
� l  3 <
�����
� [   3 <
�
�
� ]   3 :
�
�
� l  3 8
�����
� \   3 8
�
�
� ]   3 6
�
�
� m   3 4
�
� ?hOØ��
� o   4 5���� 0 zz  
� m   6 7
�
� ?��Y�,���  ��  
� o   8 9���� 0 zz  
� m   : ;
�
� @����?���  ��  
� o   < =���� 0 zz  
� m   > ?
�
� @9����"��  ��  
� o   @ A���� 0 zz  
� m   B C
�
� @<�b@����  ��  
� l  E T
�����
� [   E T
�
�
� ]   E R
�
�
� l  E P
�����
� \   E P
�
�
� ]   E N
�
�
� l  E L
�����
� [   E L
�
�
� ]   E J
�
�
� l  E H
�����
� \   E H
�
�
� o   E F���� 0 zz  
� m   F G
�
� @5򢶿]R��  ��  
� o   H I���� 0 zz  
� m   J K
�
� @bb�j1��  ��  
� o   L M�� 0 zz  
� m   N O
�
� @w���c���  ��  
� o   P Q�~�~ 0 zz  
� m   R S
�
� @ug	��D���  ��  
� o      �}�} 0 p  
� 
�
�
� r   X _
�
�
� a   X ]
�
�
� l  X [
��|�{
� [   X [
�
�
� o   X Y�z�z 0 zz  
� o   Y Z�y�y 0 zz  �|  �{  
� m   [ \
�
� ?�      
� o      �x�x 0 zz  
� 
�
�
� r   ` i
�
�
� \   ` g
�
�
� l  ` e
��w�v
� ^   ` e
�
�
� 1   ` c�u
�u 
pi  
� m   c d�t�t �w  �v  
� o   e f�s�s 0 zz  
� o      �r�r 0 z  
� 
�
�
� r   j s
�
�
� \   j q
�
�
� ]   j m
�
�
� o   j k�q�q 0 zz  
� o   k l�p�p 0 p  
� m   m p
�
� <��&3\

� o      �o�o 0 zz  
� 
��n
� r   t 
�
�
� [   t }
�
�
� \   t w
�
�
� o   t u�m�m 0 z  
� o   u v�l�l 0 zz  
� l  w |
��k�j
� ^   w |
�
�
� 1   w z�i
�i 
pi  
� m   z {�h�h �k  �j  
� o      �g�g 0 z  �n  
� 
�
�
� A   � �
�
�
� o   � ��f�f 0 x  
� m   � �
�
� >Ey��0�:
� 
��e
� r   � �
�
�
� o   � ��d�d 0 x  
� o      �c�c 0 z  �e  
� k   � �
�
� 
� 
� r   � � ]   � � o   � ��b�b 0 x   o   � ��a�a 0 x   o      �`�` 0 zz    �_ r   � � [   � �	 ]   � �

 ^   � � ]   � � o   � ��^�^ 0 zz   l  � ��]�\ \   � � ]   � � l  � ��[�Z [   � � ]   � � l  � ��Y�X \   � � ]   � � l  � ��W�V [   � � !  ]   � �"#" l  � �$�U�T$ \   � �%&% ]   � �'(' m   � �)) ?qk��v�( o   � ��S�S 0 zz  & m   � �** ?�CA3>M��U  �T  # o   � ��R�R 0 zz  ! m   � �++ @�K�/�W  �V   o   � ��Q�Q 0 zz   m   � �,, @0C1�'���Y  �X   o   � ��P�P 0 zz   m   � �-- @3��w���[  �Z   o   � ��O�O 0 zz   m   � �.. @ elΰ8�]  �\   l  � �/�N�M/ \   � �010 ]   � �232 l  � �4�L�K4 [   � �565 ]   � �787 l  � �9�J�I9 \   � �:;: ]   � �<=< l  � �>�H�G> [   � �?@? ]   � �ABA l  � �C�F�EC \   � �DED o   � ��D�D 0 zz  E m   � �FF @-{Y^��F  �E  B o   � ��C�C 0 zz  @ m   � �GG @Q��%��6�H  �G  = o   � ��B�B 0 zz  ; m   � �HH @be�m5v��J  �I  8 o   � ��A�A 0 zz  6 m   � �II @apV�����L  �K  3 o   � ��@�@ 0 zz  1 m   � �JJ @H�"
6��N  �M   o   � ��?�? 0 x  	 o   � ��>�> 0 x   o      �=�= 0 z  �_  
� KLK Z  � �MN�<�;M o   � ��:�: 0 isneg isNegN r   � �OPO d   � �QQ o   � ��9�9 0 z  P o      �8�8 0 z  �<  �;  L R�7R L   � �SS ^   � �TUT o   � ��6�6 0 z  U l  � �V�5�4V ^   � �WXW 1   � ��3
�3 
pi  X m   � ��2�2 ��5  �4  �7  
i YZY l     �1�0�/�1  �0  �/  Z [\[ l     �.�-�,�.  �-  �,  \ ]^] l     �+�*�)�+  �*  �)  ^ _`_ i  aba I     �(c�'
�( .Mth:Sinanull���     doubc o      �&�& 0 n  �'  b Q     defd L    gg I    �%h�$�% 	0 _asin  h i�#i c    jkj o    �"�" 0 n  k m    �!
�! 
nmbr�#  �$  e R      � lm
�  .ascrerr ****      � ****l o      �� 0 etext eTextm �no
� 
errnn o      �� 0 enumber eNumbero �pq
� 
erobp o      �� 0 efrom eFromq �r�
� 
errtr o      �� 
0 eto eTo�  f I    �s�� 
0 _error  s tut m    vv �ww  a s i nu xyx o    �� 0 etext eTexty z{z o    �� 0 enumber eNumber{ |}| o    �� 0 efrom eFrom} ~�~ o    �� 
0 eto eTo�  �  ` � l     ����  �  �  � ��� l     ����  �  �  � ��� i ��� I     �
��	
�
 .Mth:Cosanull���     doub� o      �� 0 n  �	  � Q      ���� L    �� \    ��� m    �� Z� l   ���� I    ���� 	0 _asin  � ��� c    ��� o    �� 0 n  � m    � 
�  
nmbr�  �  �  �  � R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  � I     ������� 
0 _error  � ��� m    �� ���  a c o s� ��� o    ���� 0 etext eText� ��� o    ���� 0 enumber eNumber� ��� o    ���� 0 efrom eFrom� ���� o    ���� 
0 eto eTo��  ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i ��� I     �����
�� .Mth:Tananull���     doub� o      ���� 0 n  ��  � Q     *���� k    �� ��� r    ��� c    ��� o    ���� 0 n  � m    ��
�� 
nmbr� o      ���� 0 x  � ���� L   	 �� I   	 ������� 	0 _asin  � ���� ^   
 ��� o   
 ���� 0 x  � l   ������ a    ��� l   ������ [    ��� ]    ��� o    ���� 0 x  � o    ���� 0 x  � m    ���� ��  ��  � m    �� ?�      ��  ��  ��  ��  ��  � R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  � I     *������� 
0 _error  � ��� m   ! "�� ���  a t a n� ��� o   " #���� 0 etext eText� ��� o   # $���� 0 enumber eNumber� ��� o   $ %���� 0 efrom eFrom� ���� o   % &���� 
0 eto eTo��  ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ������  �  -----   � ��� 
 - - - - -� ��� l     ������  �   hyperbolic   � ���    h y p e r b o l i c� ��� l     ��������  ��  ��  � ��� i ��� I     �����
�� .Mth:Sinhnull���     doub� o      ���� 0 n  ��  � Q     .���� k    �� ��� r    ��� c    ��� o    ���� 0 n  � m    ��
�� 
nmbr� o      ���� 0 x  � ���� L   	 �� ]   	 ��� m   	 
�� ?�      � l  
 ������ \   
    a   
  o   
 ���� 	0 __e__   o    ���� 0 x   a     o    ���� 	0 __e__   d     o    ���� 0 x  ��  ��  ��  � R      ��
�� .ascrerr ****      � **** o      ���� 0 etext eText ��	

�� 
errn	 o      ���� 0 enumber eNumber
 ��
�� 
erob o      ���� 0 efrom eFrom ����
�� 
errt o      ���� 
0 eto eTo��  � I   $ .������ 
0 _error    m   % & � 
 a s i n h  o   & '���� 0 etext eText  o   ' (���� 0 enumber eNumber  o   ( )���� 0 efrom eFrom �� o   ) *���� 
0 eto eTo��  ��  �  l     ��������  ��  ��    l     ��������  ��  ��    i  !  I     ��"��
�� .Mth:Coshnull���     doub" o      ���� 0 n  ��  ! Q     .#$%# k    && '(' r    )*) c    +,+ o    ���� 0 n  , m    ��
�� 
nmbr* o      ���� 0 x  ( -��- L   	 .. ]   	 /0/ m   	 
11 ?�      0 l  
 2����2 [   
 343 a   
 565 o   
 ���� 	0 __e__  6 o    ���� 0 x  4 a    787 o    ���� 	0 __e__  8 d    99 o    ���� 0 x  ��  ��  ��  $ R      ��:;
�� .ascrerr ****      � ****: o      ���� 0 etext eText; ��<=
�� 
errn< o      ���� 0 enumber eNumber= ��>?
�� 
erob> o      ���� 0 efrom eFrom? ��@��
�� 
errt@ o      ���� 
0 eto eTo��  % I   $ .��A���� 
0 _error  A BCB m   % &DD �EE 
 a c o s hC FGF o   & '���� 0 etext eTextG HIH o   ' (���� 0 enumber eNumberI JKJ o   ( )�� 0 efrom eFromK L�~L o   ) *�}�} 
0 eto eTo�~  ��   MNM l     �|�{�z�|  �{  �z  N OPO l     �y�x�w�y  �x  �w  P QRQ i STS I     �vU�u
�v .Mth:Tanhnull���     doubU o      �t�t 0 n  �u  T Q     =VWXV k    +YY Z[Z r    \]\ c    ^_^ o    �s�s 0 n  _ m    �r
�r 
nmbr] o      �q�q 0 x  [ `�p` L   	 +aa ^   	 *bcb l  	 d�o�nd \   	 efe a   	 ghg o   	 �m�m 	0 __e__  h o    �l�l 0 x  f a    iji o    �k�k 	0 __e__  j d    kk o    �j�j 0 x  �o  �n  c l   )l�i�hl [    )mnm a     opo o    �g�g 	0 __e__  p o    �f�f 0 x  n a     (qrq o     %�e�e 	0 __e__  r d   % 'ss o   % &�d�d 0 x  �i  �h  �p  W R      �ctu
�c .ascrerr ****      � ****t o      �b�b 0 etext eTextu �avw
�a 
errnv o      �`�` 0 enumber eNumberw �_xy
�_ 
erobx o      �^�^ 0 efrom eFromy �]z�\
�] 
errtz o      �[�[ 
0 eto eTo�\  X I   3 =�Z{�Y�Z 
0 _error  { |}| m   4 5~~ � 
 a t a n h} ��� o   5 6�X�X 0 etext eText� ��� o   6 7�W�W 0 enumber eNumber� ��� o   7 8�V�V 0 efrom eFrom� ��U� o   8 9�T�T 
0 eto eTo�U  �Y  R ��� l     �S�R�Q�S  �R  �Q  � ��� l     �P�O�N�P  �O  �N  � ��� l     �M���M  � J D--------------------------------------------------------------------   � ��� � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -� ��� l     �L���L  �   Logarithms   � ���    L o g a r i t h m s� ��� l     �K�J�I�K  �J  �I  � ��� i ��� I      �H��G�H 
0 _frexp  � ��F� o      �E�E 0 m  �F  �G  � k     n�� ��� Z    ���D�C� =    ��� o     �B�B 0 m  � m    �A�A  � L    �� J    
�� ��� m    ��         � ��@� m    �?�?  �@  �D  �C  � ��� r    ��� A    ��� o    �>�> 0 m  � m    �=�=  � o      �<�< 0 isneg isNeg� ��� Z   "���;�:� o    �9�9 0 isneg isNeg� r    ��� d    �� o    �8�8 0 m  � o      �7�7 0 m  �;  �:  � ��� r   # &��� m   # $�6�6  � o      �5�5 0 e  � ��� W   ' [��� Z   7 V���4�� @   7 :��� o   7 8�3�3 0 m  � m   8 9�2�2 � k   = H�� ��� r   = B��� ^   = @��� o   = >�1�1 0 m  � m   > ?�0�0 � o      �/�/ 0 m  � ��.� r   C H��� [   C F��� o   C D�-�- 0 e  � m   D E�,�, � o      �+�+ 0 e  �.  �4  � k   K V�� ��� r   K P��� ]   K N��� o   K L�*�* 0 m  � m   L M�)�) � o      �(�( 0 m  � ��'� r   Q V��� \   Q T��� o   Q R�&�& 0 e  � m   R S�%�% � o      �$�$ 0 e  �'  � F   + 6��� @   + .��� o   + ,�#�# 0 m  � m   , -�� ?�      � A   1 4��� o   1 2�"�" 0 m  � m   2 3�!�! � ��� Z  \ h��� �� o   \ ]�� 0 isneg isNeg� r   ` d��� d   ` b�� o   ` a�� 0 m  � o      �� 0 m  �   �  � ��� L   i n�� J   i m�� ��� o   i j�� 0 m  � ��� o   j k�� 0 e  �  �  � ��� l     ����  �  �  � ��� l     ����  �  �  � ��� i ��� I      ���� 	0 _logn  � ��� o      �� 0 x  �  �  � k    ;�� ��� Z    ����� B     � � o     �� 0 x    m    �
�
  � R    �	
�	 .ascrerr ****      � **** m   
  � 8 I n v a l i d   n u m b e r   ( m u s t   b e   > 0 ) . ��
� 
errn m    	���Y�  �  �  �  r    &	 I      �
�� 
0 _frexp  
 � o    �� 0 x  �  �  	 J        o      �� 0 x   �  o      ���� 0 e  �     Z   '8�� G   ' 2 A   ' * o   ' (���� 0 e   m   ( )������ ?   - 0 o   - .���� 0 e   m   . /����  k   5 �  Z   5 ^��  A   5 8!"! o   5 6���� 0 x  " m   6 7## ?栞fK� l  ; N$%&$ k   ; N'' ()( r   ; @*+* \   ; >,-, o   ; <���� 0 e  - m   < =���� + o      ���� 0 e  ) ./. r   A F010 \   A D232 o   A B���� 0 x  3 m   B C44 ?�      1 o      ���� 0 z  / 5��5 r   G N676 [   G L898 ]   G J:;: m   G H<< ?�      ; o   H I���� 0 z  9 m   J K== ?�      7 o      ���� 0 y  ��  %   (2 ^ 0.5) / 2   & �>>    ( 2   ^   0 . 5 )   /   2��    k   Q ^?? @A@ r   Q VBCB \   Q TDED o   Q R���� 0 x  E m   R S���� C o      ���� 0 z  A F��F r   W ^GHG [   W \IJI ]   W ZKLK m   W XMM ?�      L o   X Y���� 0 x  J m   Z [NN ?�      H o      ���� 0 y  ��   OPO r   _ dQRQ ^   _ bSTS o   _ `���� 0 z  T o   ` a���� 0 y  R o      ���� 0 x  P UVU r   e jWXW ]   e hYZY o   e f���� 0 x  Z o   f g���� 0 x  X o      ���� 0 z  V [\[ r   k �]^] ^   k �_`_ ]   k xaba ]   k ncdc o   k l���� 0 x  d o   l m���� 0 z  b l  n we����e \   n wfgf ]   n uhih l  n sj����j [   n sklk ]   n qmnm m   n ooo ��D=�l�n o   o p���� 0 z  l m   q rpp @0b�s{���  ��  i o   s t���� 0 z  g m   u vqq @P	"*?��  ��  ` l  x �r����r \   x �sts ]   x �uvu l  x w����w [   x xyx ]   x }z{z l  x {|����| \   x {}~} o   x y���� 0 z  ~ m   y z @A�C�l���  ��  { o   { |���� 0 z  y m   } ~�� @s��*�
��  ��  v o    ����� 0 z  t m   � ��� @���?;��  ��  ^ o      ���� 0 z  \ ��� r   � ���� o   � ����� 0 e  � o      ���� 0 y  � ���� r   � ���� [   � ���� [   � ���� \   � ���� o   � ����� 0 z  � ]   � ���� o   � ����� 0 y  � m   � ��� ?+�\a�� o   � ����� 0 x  � ]   � ���� o   � ����� 0 e  � m   � ��� ?�0     � o      ���� 0 z  ��  ��   k   �8�� ��� Z   � ������� A   � ���� o   � ����� 0 x  � m   � ��� ?栞fK�� l  � ����� k   � ��� ��� r   � ���� \   � ���� o   � ����� 0 e  � m   � ����� � o      ���� 0 e  � ���� r   � ���� \   � ���� ]   � ���� m   � ����� � o   � ����� 0 x  � m   � ����� � o      ���� 0 x  ��  �   (2 ^ 0.5) / 2   � ���    ( 2   ^   0 . 5 )   /   2��  � r   � ���� \   � ���� o   � ����� 0 x  � m   � ����� � o      ���� 0 x  � ��� r   � ���� ]   � ���� o   � ����� 0 x  � o   � ����� 0 x  � o      ���� 0 z  � ��� r   ���� ^   ���� ]   � ���� ]   � ���� o   � ����� 0 x  � o   � ����� 0 z  � l  � ������� [   � ���� ]   � ���� l  � ������� [   � ���� ]   � ���� l  � ������� [   � ���� ]   � ���� l  � ������� [   � ���� ]   � ���� l  � ������� [   � ���� ]   � ���� m   � ��� ?���� o   � ����� 0 x  � m   � ��� ?���?Vd���  ��  � o   � ����� 0 x  � m   � ��� @Һ�i���  ��  � o   � ����� 0 x  � m   � ��� @,�r�>����  ��  � o   � ����� 0 x  � m   � ��� @1�֒K�R��  ��  � o   � ����� 0 x  � m   � ��� @�c}~ݝ��  ��  � l  ������� [   ���� ]   � ���� l  � ������� [   � ���� ]   � ���� l  � ������� [   � ���� ]   � ���� l  � ������� [   � ���� ]   � ���� l  � ������� [   � ���� o   � ����� 0 x  � m   � ��� @&� �����  ��  � o   � ����� 0 x  � m   � ��� @F�,N���  ��  � o   � ����� 0 x  � m   � ��� @T�3�&����  ��  � o   � ����� 0 x  � m   � ��� @Q���^���  ��  � o   � ����� 0 x  � m   � �� @7 
�&5��  ��  � o      ���� 0 y  � � � Z  ���� >   o  ���� 0 e   m  ����   r   \   o  ���� 0 y   ]  	
	 o  ���� 0 e  
 m   ?+�\a� o      ���� 0 y  ��  ��     r   \   o  ���� 0 y   l ���� ^   o  ���� 0 z   m  ���� ��  ��   o      ���� 0 y    r  $ [  " o   ���� 0 x   o   !���� 0 y   o      ���� 0 z   �� Z %8���� >  %( o  %&���� 0 e   m  &'����   r  +4 !  [  +2"#" o  +,���� 0 z  # ]  ,1$%$ o  ,-���� 0 e  % m  -0&& ?�0     ! o      ���� 0 z  ��  ��  ��   '��' L  9;(( o  9:�� 0 z  ��  � )*) l     �~�}�|�~  �}  �|  * +,+ l     �{�z�y�{  �z  �y  , -.- l     �x�w�v�x  �w  �v  . /0/ i  #121 I     �u3�t
�u .Mth:Lognnull���     doub3 o      �s�s 0 n  �t  2 Q     4564 L    77 I    �r8�q�r 	0 _logn  8 9�p9 c    :;: o    �o�o 0 n  ; m    �n
�n 
nmbr�p  �q  5 R      �m<=
�m .ascrerr ****      � ****< o      �l�l 0 etext eText= �k>?
�k 
errn> o      �j�j 0 enumber eNumber? �i@A
�i 
erob@ o      �h�h 0 efrom eFromA �gB�f
�g 
errtB o      �e�e 
0 eto eTo�f  6 I    �dC�c�d 
0 _error  C DED m    FF �GG  l o g nE HIH o    �b�b 0 etext eTextI JKJ o    �a�a 0 enumber eNumberK LML o    �`�` 0 efrom eFromM N�_N o    �^�^ 
0 eto eTo�_  �c  0 OPO l     �]�\�[�]  �\  �[  P QRQ l     �Z�Y�X�Z  �Y  �X  R STS i $'UVU I     �WW�V
�W .Mth:Lo10null���     doubW o      �U�U 0 n  �V  V Q     $XYZX l   [\][ L    ^^ ^    _`_ ]    aba l   c�T�Sc ^    ded I    �Rf�Q�R 	0 _logn  f g�Pg c    hih o    �O�O 0 n  i m    �N
�N 
nmbr�P  �Q  e m    jj @k���T��T  �S  b m    kk @r�     ` m    ll @r�    j\   correct for minor drift   ] �mm 0   c o r r e c t   f o r   m i n o r   d r i f tY R      �Mno
�M .ascrerr ****      � ****n o      �L�L 0 etext eTexto �Kpq
�K 
errnp o      �J�J 0 enumber eNumberq �Irs
�I 
erobr o      �H�H 0 efrom eFroms �Gt�F
�G 
errtt o      �E�E 
0 eto eTo�F  Z I    $�Du�C�D 
0 _error  u vwv m    xx �yy 
 l o g 1 0w z{z o    �B�B 0 etext eText{ |}| o    �A�A 0 enumber eNumber} ~~ o    �@�@ 0 efrom eFrom ��?� o     �>�> 
0 eto eTo�?  �C  T ��� l     �=�<�;�=  �<  �;  � ��� l     �:�9�8�:  �9  �8  � ��� i (+��� I     �7��
�7 .Mth:Logbnull���     doub� o      �6�6 0 n  � �5��4
�5 
Base� o      �3�3 0 b  �4  � Q     '���� L    �� ^    ��� I    �2��1�2 	0 _logn  � ��0� c    ��� o    �/�/ 0 n  � m    �.
�. 
nmbr�0  �1  � l   ��-�,� I    �+��*�+ 	0 _logn  � ��)� c    ��� o    �(�( 0 b  � m    �'
�' 
nmbr�)  �*  �-  �,  � R      �&��
�& .ascrerr ****      � ****� o      �%�% 0 etext eText� �$��
�$ 
errn� o      �#�# 0 enumber eNumber� �"��
�" 
erob� o      �!�! 0 efrom eFrom� � ��
�  
errt� o      �� 
0 eto eTo�  � I    '���� 
0 _error  � ��� m    �� ���  l o g b� ��� o     �� 0 etext eText� ��� o     !�� 0 enumber eNumber� ��� o   ! "�� 0 efrom eFrom� ��� o   " #�� 
0 eto eTo�  �  � ��� l     ����  �  �  � ��� l     ����  �  �  �       (����� h o����������������������������������  � &�����
�	��������� ����������������������������������������������
� 
pimr� 0 _supportlib _supportLib� 
0 _error  � 	0 __e__  �
 0 _isequaldelta _isEqualDelta�	 0 _precalcsine _precalcSine� "0 _precalctangent _precalcTangent� ,0 _makenumberformatter _makeNumberFormatter� 60 _canonicalnumberformatter _canonicalNumberFormatter� ,0 _convertnumbertotext _convertNumberToText� ,0 _converttexttonumber _convertTextToNumber
� .Mth:FNumnull���     nmbr
� .Mth:PNumnull���     ctxt
� .Mth:NuHenull���     long
�  .Mth:HeNunull���     ctxt
�� .Mth:DeRanull���     doub
�� .Mth:RaDenull���     doub
�� .Mth:Abs_null���     nmbr
�� .Mth:CmpNnull���     ****
�� .Mth:MinNnull���     ****
�� .Mth:MaxNnull���     ****
�� .Mth:RouNnull���     doub�� 0 _sin  
�� .Mth:Sin_null���     doub
�� .Mth:Cos_null���     doub
�� .Mth:Tan_null���     doub�� 	0 _asin  
�� .Mth:Sinanull���     doub
�� .Mth:Cosanull���     doub
�� .Mth:Tananull���     doub
�� .Mth:Sinhnull���     doub
�� .Mth:Coshnull���     doub
�� .Mth:Tanhnull���     doub�� 
0 _frexp  �� 	0 _logn  
�� .Mth:Lognnull���     doub
�� .Mth:Lo10null���     doub
�� .Mth:Logbnull���     doub� ����� �  ��� �����
�� 
cobj� ��   �� 
�� 
frmk��  � �����
�� 
cobj� ��   ��
�� 
osax��  � ��   �� /
�� 
scpt� �� 7���������� 
0 _error  �� ����� �  ������������ 0 handlername handlerName�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo��  � ������������ 0 handlername handlerName�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo�  G������ �� &0 throwcommanderror throwCommandError�� b  ࠡ����+ � ����� �   } � � � � � � � � � � � } � � � � � � � � � � �� ����� �   } � � � � ��� � � � � � } � � � � ��� � � � � �
�� 
msng
�� 
msng� ������������ ,0 _makenumberformatter _makeNumberFormatter�� ����� �  ������ 0 formatstyle formatStyle�� 0 
localecode 
localeCode��  � �������� 0 formatstyle formatStyle�� 0 
localecode 
localeCode�� 0 asocformatter asocFormatter� ����������������������������������������������������
�� misccura�� &0 nsnumberformatter NSNumberFormatter�� 	0 alloc  �� 0 init  
�� FNStFNS0�� 40 nsnumberformatternostyle NSNumberFormatterNoStyle�� "0 setnumberstyle_ setNumberStyle_
�� FNStFNS1�� >0 nsnumberformatterdecimalstyle NSNumberFormatterDecimalStyle
�� FNStFNS2�� @0 nsnumberformattercurrencystyle NSNumberFormatterCurrencyStyle
�� FNStFNS3�� >0 nsnumberformatterpercentstyle NSNumberFormatterPercentStyle
�� FNStFNS4�� D0  nsnumberformatterscientificstyle  NSNumberFormatterScientificStyle
�� FNStFNS5�� @0 nsnumberformatterspelloutstyle NSNumberFormatterSpellOutStyle
�� 
errn���Y
�� 
erob
�� 
errt
�� 
enum�� �� &0 aslocaleparameter asLocaleParameter�� 0 
setlocale_ 
setLocale_�� ���,j+ j+ E�O��  ���,k+ Y q��  ���,k+ Y `��  ���,k+ Y O��  ���,k+ Y >��  ���,k+ Y -��  ��a ,k+ Y )a a a �a a a a O�b  �a l+ k+ O�� ������������� 60 _canonicalnumberformatter _canonicalNumberFormatter��  ��  � ���� 0 asocformatter asocFormatter� 	������������������
�� misccura�� &0 nsnumberformatter NSNumberFormatter�� 	0 alloc  �� 0 init  �� D0  nsnumberformatterscientificstyle  NSNumberFormatterScientificStyle�� "0 setnumberstyle_ setNumberStyle_�� 0 nslocale NSLocale�� 0 systemlocale systemLocale�� 0 
setlocale_ 
setLocale_�� '��,j+ j+ E�O���,k+ O���,j+ k+ O�� ������������� ,0 _convertnumbertotext _convertNumberToText�� ����� �  ���� 0 	thenumber 	theNumber��  � ������������ 0 	thenumber 	theNumber�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo� �������������������(����
�� 
kocl
�� 
nmbr
�� .corecnte****       ****�� �� 60 throwinvalidparametertype throwInvalidParameterType�� 60 _canonicalnumberformatter _canonicalNumberFormatter�� &0 stringfromnumber_ stringFromNumber_
�� 
ctxt�� 0 etext eText� �����
�� 
errn�� 0 enumber eNumber� �����
�� 
erob�� 0 efrom eFrom� ����~
�� 
errt� 
0 eto eTo�~  �� �� 
0 _error  �� C 2�kv��l j  b  �����+ Y hO*j+ �k+ �&W X 
 *졢���+ � �}8�|�{���z�} ,0 _converttexttonumber _convertTextToNumber�| �y��y �  �x�x 0 thetext theText�{  � �w�v�u�t�s�r�w 0 thetext theText�v 0 	theresult 	theResult�u 0 etext eText�t 0 enumber eNumber�s 0 efrom eFrom�r 
0 eto eTo� �q�p�oUY�n�m�l�k�j�i�h�gm�f�e���d�c
�q 
kocl
�p 
ctxt
�o .corecnte****       ****�n �m 60 throwinvalidparametertype throwInvalidParameterType�l 60 _canonicalnumberformatter _canonicalNumberFormatter�k &0 numberfromstring_ numberFromString_
�j 
msng
�i 
errn�h�Y
�g 
erob
�f 
****�e 0 etext eText� �b�a�
�b 
errn�a 0 enumber eNumber� �`�_�
�` 
erob�_ 0 efrom eFrom� �^�]�\
�^ 
errt�] 
0 eto eTo�\  �d �c 
0 _error  �z ^ I�kv��l j  b  �����+ Y hO*j+ �k+ E�O��  )�����Y hO��&W X  *a ����a + � �[��Z�Y���X
�[ .Mth:FNumnull���     nmbr�Z 0 	thenumber 	theNumber�Y �W��
�W 
Usin� {�V�U�T�V 0 formatstyle formatStyle�U  
�T FNStFNS0� �S��R
�S 
Loca� {�Q�P�O�Q 0 
localecode 
localeCode�P  
�O 
msng�R  � 	�N�M�L�K�J�I�H�G�F�N 0 	thenumber 	theNumber�M 0 formatstyle formatStyle�L 0 
localecode 
localeCode�K 0 asocformatter asocFormatter�J 0 
asocstring 
asocString�I 0 etext eText�H 0 enumber eNumber�G 0 efrom eFrom�F 
0 eto eTo� ��E�D�C�B�A�@�?�>��=�<���;�:�E &0 asnumberparameter asNumberParameter�D ,0 _makenumberformatter _makeNumberFormatter�C &0 stringfromnumber_ stringFromNumber_
�B 
msng
�A 
errn�@�Y
�? 
erob�> 
�= 
ctxt�< 0 etext eText� �9�8�
�9 
errn�8 0 enumber eNumber� �7�6�
�7 
erob�6 0 efrom eFrom� �5�4�3
�5 
errt�4 
0 eto eTo�3  �; �: 
0 _error  �X N =b  ��l+ E�O*��l+ E�O��k+ E�O��  )�����Y hO��&W X  *������+ � �2��1�0���/
�2 .Mth:PNumnull���     ctxt�1 0 thetext theText�0 �.��
�. 
Usin� {�-�,�+�- 0 formatstyle formatStyle�,  
�+ FNStFNS0� �* �)
�* 
Loca  {�(�'�&�( 0 
localecode 
localeCode�'  
�& 
msng�)  � �%�$�#�"�!� �������% 0 thetext theText�$ 0 formatstyle formatStyle�# 0 
localecode 
localeCode�" 0 asoctext asocText�! 0 asocformatter asocFormatter�  0 
asocnumber 
asocNumber� 0 
formatname 
formatName� $0 localeidentifier localeIdentifier� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo� *��������A�K�U�_�i�rz|���
�	���������������
� misccura� 0 nsstring NSString� "0 astextparameter asTextParameter� &0 stringwithstring_ stringWithString_� ,0 _makenumberformatter _makeNumberFormatter� &0 numberfromstring_ numberFromString_
� 
msng
� FNStFNS0
� FNStFNS1
� FNStFNS2
� FNStFNS3
� FNStFNS4
� FNStFNS5� 
0 locale  � $0 localeidentifier localeIdentifier
�
 
ctxt
�	 
leng
� 
errn��Y
� 
erob� 
� 
****� 0 etext eText � ��
�  
errn�� 0 enumber eNumber ����
�� 
erob�� 0 efrom eFrom ������
�� 
errt�� 
0 eto eTo��  � � 
0 _error  �/ � ���,b  ��l+ k+ E�O*��l+ E�O��k+ E�O��  ���  �E�Y Q��  �E�Y E��  �E�Y 9��  �E�Y -�a   
a E�Y �a   
a E�Y a �%a %E�O�j+ j+ a &E�O�a ,j  
a E�Y a �%a %E�O)a a a �a  a !�%a "%�%a #%Y hO�a $&W X % &*a '����a (+ )� ���������
�� .Mth:NuHenull���     long�� 0 	thenumber 	theNumber�� ��
�� 
Plac {�������� 0 padsize padSize��  ��   ����
�� 
Pref {�������� 0 	hasprefix 	hasPrefix��  
�� boovtrue��   	�������������������� 0 	thenumber 	theNumber�� 0 padsize padSize�� 0 	hasprefix 	hasPrefix�� 0 hextext hexText�� 0 	hexprefix 	hexPrefix�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo ���	��)1;Q������b��	v������ (0 asintegerparameter asIntegerParameter�� (0 asbooleanparameter asBooleanParameter
�� 
cobj�� 
�� 
leng�� 0 etext eText	 ����

�� 
errn�� 0 enumber eNumber
 ����
�� 
erob�� 0 efrom eFrom ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� � �b  ��l+ E�Ob  ��l+ E�Ob  ��l+ E�O�E�O�j �E�O�'E�Y �E�O� 
��%E�Y hO h�j���#k/�%E�O��"E�[OY��O h��,���%E�[OY��O��%W X  *a ����a + � ���������
�� .Mth:HeNunull���     ctxt�� 0 hextext hexText�� ����
�� 
Prec {�������� 0 	isprecise 	isPrecise��  
�� boovtrue��   
���������������������� 0 hextext hexText�� 0 	isprecise 	isPrecise�� 0 	thenumber 	theNumber�� 0 
isnegative 
isNegative�� 0 charref charRef�� 0 i  �� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo #����������������������������������������������������+������ "0 astextparameter asTextParameter�� (0 asbooleanparameter asBooleanParameter
�� 
ctxt
�� 
kocl
�� 
cobj
�� .corecnte****       ****�� 
�� misccura
�� 
psof
�� 
psin�� 
�� .sysooffslong    ��� null��  ��  
�� 
errn���Y
�� 
erob
�� 
bool
�� 
errt
�� 
doub�� �� 0 etext eText ����
�� 
errn�� 0 enumber eNumber ����
�� 
erob�� 0 efrom eFrom ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� ��� �b  ��l+ E�Ob  ��l+ E�O �jE�O��E�O� �[�\[Zl\Zi2E�Y hO�� �[�\[Zm\Zi2E�Y hO E�[��l kh �� E�O� *��a a  UE�O�j  	)jhY hO��kE�[OY��W X  )a a a �a a O�	 ��k a & )a a a �a a a a Y hO� 	�'E�Y hO�VW X  *a  ����a !+ "� ��G������
�� .Mth:DeRanull���     doub�� 0 n  ��   ������������ 0 n  �� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo ��������_����
�� 
doub
�� 
pi  �� ��� 0 etext eText ����
�� 
errn�� 0 enumber eNumber ����
�� 
erob�� 0 efrom eFrom ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  ��  ��&��! W X  *塢���+ � ��o������
�� .Mth:RaDenull���     doub�� 0 n  ��   ������������ 0 n  �� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo ����������
�� 
pi  �� ��� 0 etext eText �~�}
�~ 
errn�} 0 enumber eNumber �|�{
�| 
erob�{ 0 efrom eFrom �z�y�x
�z 
errt�y 
0 eto eTo�x  �� � 
0 _error  ��  ���!!W X  *䡢���+ � �w��v�u�t
�w .Mth:Abs_null���     nmbr�v 0 n  �u   �s�r�q�p�o�s 0 n  �r 0 etext eText�q 0 enumber eNumber�p 0 efrom eFrom�o 
0 eto eTo �n�m��l�k
�n 
nmbr�m 0 etext eText �j�i
�j 
errn�i 0 enumber eNumber �h�g 
�h 
erob�g 0 efrom eFrom  �f�e�d
�f 
errt�e 
0 eto eTo�d  �l �k 
0 _error  �t * ��&E�O�j �'Y �W X  *㡢���+ � �c��b�a!"�`
�c .Mth:CmpNnull���     ****�b �_#�_ #  �^�]�^ 0 n1  �] 0 n2  �a  ! �\�[�Z�Y�X�W�\ 0 n1  �[ 0 n2  �Z 0 etext eText�Y 0 enumber eNumber�X 0 efrom eFrom�W 
0 eto eTo" �V�U�T�S$�R�Q
�V 
doub
�U 
cobj
�T 
bool�S 0 etext eText$ �P�O%
�P 
errn�O 0 enumber eNumber% �N�M&
�N 
erob�M 0 efrom eFrom& �L�K�J
�L 
errt�K 
0 eto eTo�J  �R �Q 
0 _error  �` Z I��&��&lvE[�k/E�Z[�l/E�ZO�b  �	 �b  ��& jY �� iY kW X  *墣���+ � �I�H�G'(�F
�I .Mth:MinNnull���     ****�H 0 thelist theList�G  ' �E�D�C�B�A�@�?�>�E 0 thelist theList�D 0 	theresult 	theResult�C 0 aref aRef�B 0 n  �A 0 etext eText�@ 0 enumber eNumber�? 0 efrom eFrom�> 
0 eto eTo( "�=�<�;�:�9�8�7)N�6�5�= "0 aslistparameter asListParameter
�< 
cobj
�; 
nmbr
�: 
kocl
�9 .corecnte****       ****
�8 
pcnt�7 0 etext eText) �4�3*
�4 
errn�3 0 enumber eNumber* �2�1+
�2 
erob�1 0 efrom eFrom+ �0�/�.
�0 
errt�/ 
0 eto eTo�.  �6 �5 
0 _error  �F Z Ib  ��l+ E�O��k/�&E�O )�[��l kh ��,�&E�O�� �E�Y h[OY��O�W X  *餥���+ � �-^�,�+,-�*
�- .Mth:MaxNnull���     ****�, 0 thelist theList�+  , �)�(�'�&�%�$�#�"�) 0 thelist theList�( 0 	theresult 	theResult�' 0 aref aRef�& 0 n  �% 0 etext eText�$ 0 enumber eNumber�# 0 efrom eFrom�" 
0 eto eTo- n�!� �����.����! "0 aslistparameter asListParameter
�  
cobj
� 
nmbr
� 
kocl
� .corecnte****       ****
� 
pcnt� 0 etext eText. ��/
� 
errn� 0 enumber eNumber/ ��0
� 
erob� 0 efrom eFrom0 ���
� 
errt� 
0 eto eTo�  � � 
0 _error  �* Z Ib  ��l+ E�O��k/�&E�O )�[��l kh ��,�&E�O�� �E�Y h[OY��O�W X  *餥���+ � ����12�
� .Mth:RouNnull���     doub� 0 num  � �34
� 
Plac3 {���
� 0 decimalplaces decimalPlaces�  �
  4 �	5�
�	 
Dire5 {���� &0 roundingdirection roundingDirection�  
� MRndRNhE�  1 ����� ������� 0 num  � 0 decimalplaces decimalPlaces� &0 roundingdirection roundingDirection� 0 themultiplier theMultiplier�  0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo2 ����������
+��I�������������6������� "0 asrealparameter asRealParameter�� (0 asintegerparameter asIntegerParameter�� 

�� MRndRNhE
�� MRndRNhT
�� MRndRN_T
�� MRndRN_U
�� 
bool
�� MRndRN_D�� >0 throwinvalidparameterconstant throwInvalidParameterConstant�� 0 etext eText6 ����7
�� 
errn�� 0 enumber eNumber7 ����8
�� 
erob�� 0 efrom eFrom8 ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �D/b  ��l+ E�Ob  ��l+ E�O�j �$E�O�� � �!E�Y hO��  3��lv�l!k#kv 
�k"E�Y �j ��k"E�Y 	��k"E�Y ���  1��lv�k#kv 
�k"E�Y �j ��k"E�Y 	��k"E�Y k��  
�k"E�Y ]��  $�j
 	�k#j �& 
�k"E�Y 	�kk"E�Y 5��  $�j
 	�k#j �& 
�k"E�Y 	�kk"E�Y b  ��l+ O�j  	�k"Y �j 	��"Y ��!W X  *a ����a + � �������9:���� 0 _sin  �� ��;�� ;  ���� 0 x  ��  9 �������������� 0 x  �� 0 isneg isNeg�� 0 y  �� 0 z  �� 0 z2  �� 0 zz  : ������������R������������������������ 
�� 
cobj��h
�� 
pi  �� ��� �� �� 
�� 
bool����#j  $�j 	�'E�Y hOb  ��#�"k/EY hO��#� �!E�O�jE�O� 	�'E�Y hO���! k"E�O��� k"� E�O�l#k  �kE�O�kE�Y hO��#E�O�m �E�O��E�Y hO��� �� �� E�O�� E�O�k 
 �l �& .��l!�� � �� a � a � a � a  E�Y +��� a � a � a � a � a � a  E�O� 	�'E�Y hO�� ��		����<=��
�� .Mth:Sin_null���     doub�� 0 n  ��  < �������������� 0 n  �� 0 x  �� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo= ������>	����
�� 
nmbr�� 0 _sin  �� 0 etext eText> ����?
�� 
errn�� 0 enumber eNumber? ����@
�� 
erob�� 0 efrom eFrom@ ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  ��  *��&k+ W X  *䢣���+ � ��	-����AB��
�� .Mth:Cos_null���     doub�� 0 n  ��  A ������������ 0 n  �� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eToB ��������C	D����
�� 
nmbr�� Z�� 0 _sin  �� 0 etext eTextC ����D
�� 
errn�� 0 enumber eNumberD ����E
�� 
erob�� 0 efrom eFromE ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� ! *��&�k+ W X  *塢���+ � ��	T����FG��
�� .Mth:Tan_null���     doub�� 0 n  ��  F ������������������������ 0 n  �� 0 x  �� 0 isneg isNeg�� 0 y  �� 0 z  �� 0 z2  �� 0 zz  �� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eToG !������������������	�����	��	�	�	�	�



(
)
*
+��H
O��
�� 
nmbr�� �� Z��
�� 
bool
�� 
errn���Y
�� 
erob�� 
� 
cobj�h
� 
pi  � �� � � 0 etext eTextH ��I
� 
errn� 0 enumber eNumberI ��J
� 
erob� 0 efrom eFromJ ���
� 
errt� 
0 eto eTo�  � � 
0 _error  ��5 ��&E�O��#j  ?�j 	�'E�Y hO�� 
 �� �& )�����Y hOb  ��#�"k/EY hO��#� �!E�O�jE�O� 	�'E�Y hO���!!k"E�O��� k"� E�O�l#k  �kE�O�kE�Y hO��a  �a  �a  E�O�� E�O�a  4��� a � a � a  �a � a � a � a !E�Y �E�O�l 
 	�a  �& 
i�!E�Y hO� 	�'E�Y hO�W X  *a ����a +  � �
k�~�}KL�|� 	0 _asin  �~ �{M�{ M  �z�z 0 n  �}  K �y�x�w�v�u�t�y 0 n  �x 0 x  �w 0 isneg isNeg�v 0 zz  �u 0 p  �t 0 z  L �s�r�q�p
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
��o
�
�)*+,-.FGHIJ�n
�s 
errn�r�Y
�q 
erob�p 
�o 
pi  �n ��| ��jE�O� 	�'E�Y hO�k )�����Y hO�� Xk�E�O�� �� �� �� � ��� �� �� �!E�O���$E�O_ �!�E�O�� a E�O��_ �!E�Y ]�a  �E�Y O�� E�O�a � a � a � a � a � a  �a � a � a � a � a !� �E�O� 	�'E�Y hO�_ a !!� �mb�l�kNO�j
�m .Mth:Sinanull���     doub�l 0 n  �k  N �i�h�g�f�e�i 0 n  �h 0 etext eText�g 0 enumber eNumber�f 0 efrom eFrom�e 
0 eto eToO �d�c�bPv�a�`
�d 
nmbr�c 	0 _asin  �b 0 etext eTextP �_�^Q
�_ 
errn�^ 0 enumber eNumberQ �]�\R
�] 
erob�\ 0 efrom eFromR �[�Z�Y
�[ 
errt�Z 
0 eto eTo�Y  �a �` 
0 _error  �j  *��&k+ W X  *䡢���+ � �X��W�VST�U
�X .Mth:Cosanull���     doub�W 0 n  �V  S �T�S�R�Q�P�T 0 n  �S 0 etext eText�R 0 enumber eNumber�Q 0 efrom eFrom�P 
0 eto eToT �O�N�M�LU��K�J�O Z
�N 
nmbr�M 	0 _asin  �L 0 etext eTextU �I�HV
�I 
errn�H 0 enumber eNumberV �G�FW
�G 
erob�F 0 efrom eFromW �E�D�C
�E 
errt�D 
0 eto eTo�C  �K �J 
0 _error  �U ! �*��&k+ W X  *塢���+ � �B��A�@XY�?
�B .Mth:Tananull���     doub�A 0 n  �@  X �>�=�<�;�:�9�> 0 n  �= 0 x  �< 0 etext eText�; 0 enumber eNumber�: 0 efrom eFrom�9 
0 eto eToY �8��7�6Z��5�4
�8 
nmbr�7 	0 _asin  �6 0 etext eTextZ �3�2[
�3 
errn�2 0 enumber eNumber[ �1�0\
�1 
erob�0 0 efrom eFrom\ �/�.�-
�/ 
errt�. 
0 eto eTo�-  �5 �4 
0 _error  �? + ��&E�O*��� k�$!k+ W X  *墣���+ � �,��+�*]^�)
�, .Mth:Sinhnull���     doub�+ 0 n  �*  ] �(�'�&�%�$�#�( 0 n  �' 0 x  �& 0 etext eText�% 0 enumber eNumber�$ 0 efrom eFrom�# 
0 eto eTo^ �"��!_� �
�" 
nmbr�! 0 etext eText_ ��`
� 
errn� 0 enumber eNumber` ��a
� 
erob� 0 efrom eFroma ���
� 
errt� 
0 eto eTo�  �  � 
0 _error  �) / ��&E�O�b  �$b  �'$ W X  *䢣���+ � �!��bc�
� .Mth:Coshnull���     doub� 0 n  �  b ������� 0 n  � 0 x  � 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eToc �1�dD��

� 
nmbr� 0 etext eTextd �	�e
�	 
errn� 0 enumber eNumbere ��f
� 
erob� 0 efrom eFromf ���
� 
errt� 
0 eto eTo�  � �
 
0 _error  � / ��&E�O�b  �$b  �'$ W X  *䢣���+ � �T�� gh��
� .Mth:Tanhnull���     doub� 0 n  �   g �������������� 0 n  �� 0 x  �� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eToh ����i~����
�� 
nmbr�� 0 etext eTexti ����j
�� 
errn�� 0 enumber eNumberj ����k
�� 
erob�� 0 efrom eFromk ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� > -��&E�Ob  �$b  �'$b  �$b  �'$!W X  *㢣���+ � �������lm���� 
0 _frexp  �� ��n�� n  ���� 0 m  ��  l �������� 0 m  �� 0 isneg isNeg�� 0 e  m ����
�� 
bool�� o�j  
�jlvY hO�jE�O� 	�'E�Y hOjE�O 3h��	 �k�&�k �l!E�O�kE�Y �l E�O�kE�[OY��O� 	�'E�Y hO��lv� �������op���� 	0 _logn  �� ��q�� q  ���� 0 x  ��  o ���������� 0 x  �� 0 e  �� 0 z  �� 0 y  p ������������#4opq���������������
�� 
errn���Y�� 
0 _frexp  
�� 
cobj����
�� 
bool��<�j )��l�Y hO*�k+ E[�k/E�Z[�l/E�ZO��
 �l�& j�� �kE�O��E�O� �E�Y �kE�O� �E�O��!E�O�� E�O�� � �� � ��� �� �!E�O�E�O��� ��a  E�Y ��� �kE�Ol� kE�Y �kE�O�� E�O�� a � a � a � a � a � a  �a � a � a � a � a !E�O�j ��� E�Y hO��l!E�O��E�O�j ��a  E�Y hO�� ��2����rs��
�� .Mth:Lognnull���     doub�� 0 n  ��  r ������������ 0 n  �� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTos ������tF����
�� 
nmbr�� 	0 _logn  �� 0 etext eTextt ����u
�� 
errn�� 0 enumber eNumberu ����v
�� 
erob�� 0 efrom eFromv �����
�� 
errt�� 
0 eto eTo�  �� �� 
0 _error  ��  *��&k+ W X  *䡢���+ � �V��wx�
� .Mth:Lo10null���     doub� 0 n  �  w ������ 0 n  � 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTox 
��jkl�yx��
� 
nmbr� 	0 _logn  � 0 etext eTexty ��z
� 
errn� 0 enumber eNumberz ��{
� 
erob� 0 efrom eFrom{ ���
� 
errt� 
0 eto eTo�  � � 
0 _error  � % *��&k+ �!� �!W X  *硢���+ 	� ����|}�
� .Mth:Logbnull���     doub� 0 n  � ���
� 
Base� 0 b  �  | ������� 0 n  � 0 b  � 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo} ���~���
� 
nmbr� 	0 _logn  � 0 etext eText~ ��
� 
errn� 0 enumber eNumber ���
� 
erob� 0 efrom eFrom� ���
� 
errt� 
0 eto eTo�  � � 
0 _error  � ( *��&k+ *��&k+ !W X  *䢣���+  ascr  ��ޭ