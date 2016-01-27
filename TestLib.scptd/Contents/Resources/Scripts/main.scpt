FasdUAS 1.101.10   ��   ��    k             l      ��  ��    TestLib -- unit testing framework and other testing/profiling tools


TO DO:

- should all code+terms not immediately related to unit testing be moved to a separate module (or vice-versa, moving UT code to `UnitTestLib`)? (the less risk of keyword/AE code collisions with the code being tested, the better)

- a unit testing framework should take a .scpt file containing one or more script objects, each representing a test suite, and each of those script objects containing one or more handlers representing individual unit tests. Both scripts and handlers should have 'test_' prefixes; OSAKit should introspect the script to get all names, then create a new CI for each test, construct an AE to invoke a handler (plus handlers to setUp and tearDown), and perform the test.

	- note that `property parent : a reference to script "TestLib"` would also work for importing TestLib into users' test scripts (this delegates the test script's unhandled commands to TestLib but doesn't embed TestLib in the test script when it's saved), but users would need to be careful that test commands appearing inside tell blocks are always dispatched to the correct target, so it may be safer if users always bind TestLib reference to `TestLib` property and qualify all test commands accordingly, e.g. `TestLib's assertEqual(...)` is more verbose than `assertEqual(...)` but also more foolproof (which is no bad thing in unit test code)
	
	- basically, keeping to compiled .scpt files rather than running .applescript snippets via `osascript` avoids any risk of .applescript test scripts not compiling correctly (since they're already compiled)
	
- options for automatically spiking TIDs and considering/ignoring options before calling `test_NAME` handler; also, what about an option for composing/decomposing unicode (assuming that's an issue in AS/Cocoa, e.g. when comparing/sorting AS/NS strings); note that localization is harder to spike, but should be done if possible as it affects date and number coercions

- what other assert test options (e.g. `is in`, `is not`, etc)? best solution would be to pass an `assert [is/is not/is in/is not in/is type/is not type/etc] comparator` script object that performs the appropriate test as an additional parameter; that avoids adding lots of optional params for each comparison type (most of which are rarely used), which would bloat the API and be non-extensible; in particular, asserting a script object-based result will most likely require a custom checker (otherwise checking each detail would require a separate assert, since script objects don't compare for logical equivalence, only identify); ditto when result being checked is an ASOC ocid specifier (in which case the other value should be checked to see if it's also an ocid, and if it is then use `(v1's isEqual: v2)`)

      � 	 	   T e s t L i b   - -   u n i t   t e s t i n g   f r a m e w o r k   a n d   o t h e r   t e s t i n g / p r o f i l i n g   t o o l s 
 
 
 T O   D O : 
 
 -   s h o u l d   a l l   c o d e + t e r m s   n o t   i m m e d i a t e l y   r e l a t e d   t o   u n i t   t e s t i n g   b e   m o v e d   t o   a   s e p a r a t e   m o d u l e   ( o r   v i c e - v e r s a ,   m o v i n g   U T   c o d e   t o   ` U n i t T e s t L i b ` ) ?   ( t h e   l e s s   r i s k   o f   k e y w o r d / A E   c o d e   c o l l i s i o n s   w i t h   t h e   c o d e   b e i n g   t e s t e d ,   t h e   b e t t e r ) 
 
 -   a   u n i t   t e s t i n g   f r a m e w o r k   s h o u l d   t a k e   a   . s c p t   f i l e   c o n t a i n i n g   o n e   o r   m o r e   s c r i p t   o b j e c t s ,   e a c h   r e p r e s e n t i n g   a   t e s t   s u i t e ,   a n d   e a c h   o f   t h o s e   s c r i p t   o b j e c t s   c o n t a i n i n g   o n e   o r   m o r e   h a n d l e r s   r e p r e s e n t i n g   i n d i v i d u a l   u n i t   t e s t s .   B o t h   s c r i p t s   a n d   h a n d l e r s   s h o u l d   h a v e   ' t e s t _ '   p r e f i x e s ;   O S A K i t   s h o u l d   i n t r o s p e c t   t h e   s c r i p t   t o   g e t   a l l   n a m e s ,   t h e n   c r e a t e   a   n e w   C I   f o r   e a c h   t e s t ,   c o n s t r u c t   a n   A E   t o   i n v o k e   a   h a n d l e r   ( p l u s   h a n d l e r s   t o   s e t U p   a n d   t e a r D o w n ) ,   a n d   p e r f o r m   t h e   t e s t . 
 
 	 -   n o t e   t h a t   ` p r o p e r t y   p a r e n t   :   a   r e f e r e n c e   t o   s c r i p t   " T e s t L i b " `   w o u l d   a l s o   w o r k   f o r   i m p o r t i n g   T e s t L i b   i n t o   u s e r s '   t e s t   s c r i p t s   ( t h i s   d e l e g a t e s   t h e   t e s t   s c r i p t ' s   u n h a n d l e d   c o m m a n d s   t o   T e s t L i b   b u t   d o e s n ' t   e m b e d   T e s t L i b   i n   t h e   t e s t   s c r i p t   w h e n   i t ' s   s a v e d ) ,   b u t   u s e r s   w o u l d   n e e d   t o   b e   c a r e f u l   t h a t   t e s t   c o m m a n d s   a p p e a r i n g   i n s i d e   t e l l   b l o c k s   a r e   a l w a y s   d i s p a t c h e d   t o   t h e   c o r r e c t   t a r g e t ,   s o   i t   m a y   b e   s a f e r   i f   u s e r s   a l w a y s   b i n d   T e s t L i b   r e f e r e n c e   t o   ` T e s t L i b `   p r o p e r t y   a n d   q u a l i f y   a l l   t e s t   c o m m a n d s   a c c o r d i n g l y ,   e . g .   ` T e s t L i b ' s   a s s e r t E q u a l ( . . . ) `   i s   m o r e   v e r b o s e   t h a n   ` a s s e r t E q u a l ( . . . ) `   b u t   a l s o   m o r e   f o o l p r o o f   ( w h i c h   i s   n o   b a d   t h i n g   i n   u n i t   t e s t   c o d e ) 
 	 
 	 -   b a s i c a l l y ,   k e e p i n g   t o   c o m p i l e d   . s c p t   f i l e s   r a t h e r   t h a n   r u n n i n g   . a p p l e s c r i p t   s n i p p e t s   v i a   ` o s a s c r i p t `   a v o i d s   a n y   r i s k   o f   . a p p l e s c r i p t   t e s t   s c r i p t s   n o t   c o m p i l i n g   c o r r e c t l y   ( s i n c e   t h e y ' r e   a l r e a d y   c o m p i l e d ) 
 	 
 -   o p t i o n s   f o r   a u t o m a t i c a l l y   s p i k i n g   T I D s   a n d   c o n s i d e r i n g / i g n o r i n g   o p t i o n s   b e f o r e   c a l l i n g   ` t e s t _ N A M E `   h a n d l e r ;   a l s o ,   w h a t   a b o u t   a n   o p t i o n   f o r   c o m p o s i n g / d e c o m p o s i n g   u n i c o d e   ( a s s u m i n g   t h a t ' s   a n   i s s u e   i n   A S / C o c o a ,   e . g .   w h e n   c o m p a r i n g / s o r t i n g   A S / N S   s t r i n g s ) ;   n o t e   t h a t   l o c a l i z a t i o n   i s   h a r d e r   t o   s p i k e ,   b u t   s h o u l d   b e   d o n e   i f   p o s s i b l e   a s   i t   a f f e c t s   d a t e   a n d   n u m b e r   c o e r c i o n s 
 
 -   w h a t   o t h e r   a s s e r t   t e s t   o p t i o n s   ( e . g .   ` i s   i n ` ,   ` i s   n o t ` ,   e t c ) ?   b e s t   s o l u t i o n   w o u l d   b e   t o   p a s s   a n   ` a s s e r t   [ i s / i s   n o t / i s   i n / i s   n o t   i n / i s   t y p e / i s   n o t   t y p e / e t c ]   c o m p a r a t o r `   s c r i p t   o b j e c t   t h a t   p e r f o r m s   t h e   a p p r o p r i a t e   t e s t   a s   a n   a d d i t i o n a l   p a r a m e t e r ;   t h a t   a v o i d s   a d d i n g   l o t s   o f   o p t i o n a l   p a r a m s   f o r   e a c h   c o m p a r i s o n   t y p e   ( m o s t   o f   w h i c h   a r e   r a r e l y   u s e d ) ,   w h i c h   w o u l d   b l o a t   t h e   A P I   a n d   b e   n o n - e x t e n s i b l e ;   i n   p a r t i c u l a r ,   a s s e r t i n g   a   s c r i p t   o b j e c t - b a s e d   r e s u l t   w i l l   m o s t   l i k e l y   r e q u i r e   a   c u s t o m   c h e c k e r   ( o t h e r w i s e   c h e c k i n g   e a c h   d e t a i l   w o u l d   r e q u i r e   a   s e p a r a t e   a s s e r t ,   s i n c e   s c r i p t   o b j e c t s   d o n ' t   c o m p a r e   f o r   l o g i c a l   e q u i v a l e n c e ,   o n l y   i d e n t i f y ) ;   d i t t o   w h e n   r e s u l t   b e i n g   c h e c k e d   i s   a n   A S O C   o c i d   s p e c i f i e r   ( i n   w h i c h   c a s e   t h e   o t h e r   v a l u e   s h o u l d   b e   c h e c k e d   t o   s e e   i f   i t ' s   a l s o   a n   o c i d ,   a n d   i f   i t   i s   t h e n   u s e   ` ( v 1 ' s   i s E q u a l :   v 2 ) ` ) 
 
     
  
 l     ��������  ��  ��        j     �� �� 0 _supportlib _supportLib  N        4     �� 
�� 
scpt  m       �   " L i b r a r y S u p p o r t L i b      l     ��������  ��  ��        x    �� ����    4    �� 
�� 
frmk  m   
    �    F o u n d a t i o n��        l     ��������  ��  ��        x    �� ����    2   ��
�� 
osax��       !   l     ��������  ��  ��   !  " # " l     ��������  ��  ��   #  $ % $ l     �� & '��   & J D--------------------------------------------------------------------    ' � ( ( � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - %  ) * ) l     �� + ,��   +   Test Utilities    , � - -    T e s t   U t i l i t i e s *  . / . l     ��������  ��  ��   /  0 1 0 i   ! 2 3 2 I      �� 4���� 0 istype isType 4  5 6 5 o      ���� 0 thevalue theValue 6  7�� 7 o      ���� 0 typename typeName��  ��   3 L      8 8 >      9 : 9 l    	 ;���� ; I    	�� < =
�� .corecnte****       **** < J      > >  ?�� ? o     ���� 0 thevalue theValue��   = �� @��
�� 
kocl @ o    ���� 0 typename typeName��  ��  ��   : m   	 
����   1  A B A l     ��������  ��  ��   B  C D C i  " % E F E I      �� G���� 0 
randomword 
randomWord G  H I H o      ���� 0 	minlength 	minLength I  J�� J o      ���� 0 	maxlength 	maxLength��  ��   F l    ' K L M K k     ' N N  O P O r      Q R Q m      S S � T T   R o      ���� 0 s   P  U V U U    $ W X W r     Y Z Y b     [ \ [ o    ���� 0 s   \ n     ] ^ ] 3    ��
�� 
cobj ^ m     _ _ � ` ` 4 a b c d e f g h i j k l m n o p q r s t u v w x y z Z o      ���� 0 s   X l    a���� a I    b�� c b z����
�� .sysorandnmbr    ��� nmbr
�� misccura��   c �� d e
�� 
from d o    ���� 0 	minlength 	minLength e �� f��
�� 
to   f o    ���� 0 	maxlength 	maxLength��  ��  ��   V  g�� g L   % ' h h o   % &���� 0 s  ��   L R L TO DO: can this be turned into a genuinely useful test tool? if not, delete    M � i i �   T O   D O :   c a n   t h i s   b e   t u r n e d   i n t o   a   g e n u i n e l y   u s e f u l   t e s t   t o o l ?   i f   n o t ,   d e l e t e D  j k j l     ��������  ��  ��   k  l m l l     �� n o��   n J D--------------------------------------------------------------------    o � p p � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - m  q r q l     �� s t��   s   Timing/Profiling    t � u u "   T i m i n g / P r o f i l i n g r  v w v l     ��������  ��  ��   w  x y x i  & ) z { z I     �� |��
�� .���:MTmrnull��� ��� ctxt | |���� }�� ~��  ��   } o      ���� 0 nametext nameText��   ~ l      ����  m       � � � � �  ��  ��  ��   { h     �� ��� 0 timerobject TimerObject � k       � �  � � � l     �� � ���   � � � note: AS can't serialize ASOC objects when [auto-]saving scripts, so store start and end times as NSTimeInterval (Double/real) to avoid any complaints    � � � �.   n o t e :   A S   c a n ' t   s e r i a l i z e   A S O C   o b j e c t s   w h e n   [ a u t o - ] s a v i n g   s c r i p t s ,   s o   s t o r e   s t a r t   a n d   e n d   t i m e s   a s   N S T i m e I n t e r v a l   ( D o u b l e / r e a l )   t o   a v o i d   a n y   c o m p l a i n t s �  � � � x     �� �����   � 4    �� �
�� 
frmk � m     � � � � �  F o u n d a t i o n��   �  � � � j    �� ��� 0 
_starttime 
_startTime � m    ��
�� 
msng �  � � � j    �� ��� 0 _totalseconds _totalSeconds � m     � �          �  � � � j    �� ��� 0 
_isrunning 
_isRunning � m    ��
�� boovfals �  � � � l     ��������  ��  ��   �  � � � i    � � � I      �������� 0 	timername 	timerName��  ��   � L      � � o     ���� 0 nametext nameText �  � � � l     ��������  ��  ��   �  � � � i    � � � I      �������� 0 
starttimer 
startTimer��  ��   � k     ' � �  � � � Z     � ����� � o     ���� 0 
_isrunning 
_isRunning � L    
����  ��  ��   �  � � � r     � � � m    ��
�� boovtrue � o      ���� 0 
_isrunning 
_isRunning �  � � � r    $ � � � n    � � � I    �������� @0 timeintervalsincereferencedate timeIntervalSinceReferenceDate��  ��   � n    � � � o    ���� 0 nsdate NSDate � m    ��
�� misccura � o      ���� 0 
_starttime 
_startTime �  ��� � L   % ' � �  f   % &��   �  � � � l     ��������  ��  ��   �  � � � i    � � � I      �������� 0 	stoptimer 	stopTimer��  ��   � k     8 � �  � � � Z     � ����� � H      � � o     �� 0 
_isrunning 
_isRunning � L   	  � � m   	 
�~�~  ��  ��   �  � � � r     � � � \     � � � l    ��}�| � n    � � � I    �{�z�y�{ @0 timeintervalsincereferencedate timeIntervalSinceReferenceDate�z  �y   � n    � � � o    �x�x 0 nsdate NSDate � m    �w
�w misccura�}  �|   � o    �v�v 0 
_starttime 
_startTime � o      �u�u 0 elapsedtime elapsedTime �  � � � r     - � � � [     ' � � � o     %�t�t 0 _totalseconds _totalSeconds � o   % &�s�s 0 elapsedtime elapsedTime � o      �r�r 0 _totalseconds _totalSeconds �  � � � r   . 5 � � � m   . /�q
�q boovfals � o      �p�p 0 
_isrunning 
_isRunning �  ��o � L   6 8 � � o   6 7�n�n 0 elapsedtime elapsedTime�o   �  � � � l     �m�l�k�m  �l  �k   �  � � � i    # � � � I      �j�i�h�j 0 elapsedtime elapsedTime�i  �h   � Z      � ��g � � o     �f�f 0 
_isrunning 
_isRunning � L     � � \     � � � l    ��e�d � n    � � � I   	 �c�b�a�c @0 timeintervalsincereferencedate timeIntervalSinceReferenceDate�b  �a   � o    	�`�` 0 nsdate NSDate�e  �d   � o    �_�_ 0 
_starttime 
_startTime�g   � L     � � m    �^�^   �  � � � l     �]�\�[�]  �\  �[   �  ��Z � i  $ ' � � � I      �Y�X�W�Y 0 	totaltime 	totalTime�X  �W   � Z      � ��V � � o     �U�U 0 
_isrunning 
_isRunning � L     � � [     � � � o    �T�T 0 _totalseconds _totalSeconds � I    �S�R�Q�S 0 elapsedtime elapsedTime�R  �Q  �V   � L     � � o    �P�P 0 _totalseconds _totalSeconds�Z   y  � � � l     �O�N�M�O  �N  �M   �  � � � l     �L�K�J�L  �K  �J   �  � � � l     �I � �I   � J D--------------------------------------------------------------------     � � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - �  l     �H�H     Unit Test Framework    � (   U n i t   T e s t   F r a m e w o r k  l     �G�F�E�G  �F  �E   	
	 l      j   * ,�D�D 40 _defectiveassertionerror _DefectiveAssertionError m   * +�C�C@ e _ `assert�` failed due to bad parameter (or internal bug, not that there should be any of those)    � �   ` a s s e r t & `   f a i l e d   d u e   t o   b a d   p a r a m e t e r   ( o r   i n t e r n a l   b u g ,   n o t   t h a t   t h e r e   s h o u l d   b e   a n y   o f   t h o s e )
  l      j   - /�B�B 00 _abortedassertionerror _AbortedAssertionError m   - .�A�AA P J raised by `assert�` handlers upon failed assertion to terminate that test    � �   r a i s e d   b y   ` a s s e r t & `   h a n d l e r s   u p o n   f a i l e d   a s s e r t i o n   t o   t e r m i n a t e   t h a t   t e s t  l     �@�?�>�@  �?  �>    l      j   0 2�=�= 0 _isequaldelta _isEqualDelta m   0 1 >.�&֕ > 8 allow for limited precision when asserting real results    �   p   a l l o w   f o r   l i m i t e d   p r e c i s i o n   w h e n   a s s e r t i n g   r e a l   r e s u l t s !"! l     �<�;�:�<  �;  �:  " #$# h   3 >�9%�9 0 _novalue _NoValue% l     �8&'�8  & � � TO DO: would it be safe enough just to use `�class ���!�` (no value placeholder)? (i.e. optional handler params require a literal value, so `_NoValue` script object can't be used there)   ' �((t   T O   D O :   w o u l d   i t   b e   s a f e   e n o u g h   j u s t   t o   u s e   ` � c l a s s   � � � ! � `   ( n o   v a l u e   p l a c e h o l d e r ) ?   ( i . e .   o p t i o n a l   h a n d l e r   p a r a m s   r e q u i r e   a   l i t e r a l   v a l u e ,   s o   ` _ N o V a l u e `   s c r i p t   o b j e c t   c a n ' t   b e   u s e d   t h e r e )$ )*) l     �7�6�5�7  �6  �5  * +,+ h   ? J�4-�4 00 _abortedassertiontoken _AbortedAssertionToken- l     �3./�3  .-' when raising error number _AbortedAssertionError, the `from` parameter should carry this unique identifier to confirm error was raised by TestLib, and isn't merely an error in the test code/code being tested that happens to use the same error number (in which case it should be treated as such)   / �00N   w h e n   r a i s i n g   e r r o r   n u m b e r   _ A b o r t e d A s s e r t i o n E r r o r ,   t h e   ` f r o m `   p a r a m e t e r   s h o u l d   c a r r y   t h i s   u n i q u e   i d e n t i f i e r   t o   c o n f i r m   e r r o r   w a s   r a i s e d   b y   T e s t L i b ,   a n d   i s n ' t   m e r e l y   a n   e r r o r   i n   t h e   t e s t   c o d e / c o d e   b e i n g   t e s t e d   t h a t   h a p p e n s   t o   u s e   t h e   s a m e   e r r o r   n u m b e r   ( i n   w h i c h   c a s e   i t   s h o u l d   b e   t r e a t e d   a s   s u c h ), 121 l     �2�1�0�2  �1  �0  2 343 l     �/56�/  52, the `class` property of error records passed to TestReport by `assert�` handlers; TestReport checks this record property to determine how to convert test data to its literal representation (unlike other records, which are converted wholesale, error info record properties are individually converted)   6 �77X   t h e   ` c l a s s `   p r o p e r t y   o f   e r r o r   r e c o r d s   p a s s e d   t o   T e s t R e p o r t   b y   ` a s s e r t & `   h a n d l e r s ;   T e s t R e p o r t   c h e c k s   t h i s   r e c o r d   p r o p e r t y   t o   d e t e r m i n e   h o w   t o   c o n v e r t   t e s t   d a t a   t o   i t s   l i t e r a l   r e p r e s e n t a t i o n   ( u n l i k e   o t h e r   r e c o r d s ,   w h i c h   a r e   c o n v e r t e d   w h o l e s a l e ,   e r r o r   i n f o   r e c o r d   p r o p e r t i e s   a r e   i n d i v i d u a l l y   c o n v e r t e d )4 898 j   K O�.:�. $0 _caughterrorinfo _caughtErrorInfo: m   K N�-
�- 
����9 ;<; l     �,�+�*�,  �+  �*  < =>= j   P m�)?�) *0 _defaulterrorrecord _defaultErrorRecord? K   P l@@ �(AB
�( 
pclsA o   S T�'�' $0 _caughterrorinfo _caughtErrorInfoB �&CD�& 0 	errortext 	errorTextC o   W X�%�% 0 _novalue _NoValueD �$EF�$ 0 errornumber errorNumberE o   [ \�#�# 0 _novalue _NoValueF �"GH�" 0 
errorvalue 
errorValueG o   _ `�!�! 0 _novalue _NoValueH � IJ�  0 expectedtype expectedTypeI o   c d�� 0 _novalue _NoValueJ �K�� 0 partialresult partialResultK o   g h�� 0 _novalue _NoValue�  > LML l     ����  �  �  M NON l     �PQ�  P 0 * note: omitted parameters use �class ���!�   Q �RR T   n o t e :   o m i t t e d   p a r a m e t e r s   u s e   � c l a s s   � � � ! �O STS l     ����  �  �  T UVU l     �WX�  W  -----   X �YY 
 - - - - -V Z[Z l     �\]�  \   test report   ] �^^    t e s t   r e p o r t[ _`_ l     ����  �  �  ` aba l     cdec j   n r�f� $0 _testsuiteobject _testSuiteObjectf m   n q�
� 
msngd � � the test suite object that was passed to `perform unit test`; assigned and cleared at start and end of `perform unit test`; may be used by assert handlers (e.g. `assert test error` uses it when calling a `call_NAME` handler)   e �gg�   t h e   t e s t   s u i t e   o b j e c t   t h a t   w a s   p a s s e d   t o   ` p e r f o r m   u n i t   t e s t ` ;   a s s i g n e d   a n d   c l e a r e d   a t   s t a r t   a n d   e n d   o f   ` p e r f o r m   u n i t   t e s t ` ;   m a y   b e   u s e d   b y   a s s e r t   h a n d l e r s   ( e . g .   ` a s s e r t   t e s t   e r r o r `   u s e s   i t   w h e n   c a l l i n g   a   ` c a l l _ N A M E `   h a n d l e r )b hih l     jklj j   s w�m� 0 _testreport _testReportm m   s v�
� 
msngk x r a single test_NAME handler may perform multiple asserts, the result of each is recorded in TestReport object here   l �nn �   a   s i n g l e   t e s t _ N A M E   h a n d l e r   m a y   p e r f o r m   m u l t i p l e   a s s e r t s ,   t h e   r e s u l t   o f   e a c h   i s   r e c o r d e d   i n   T e s t R e p o r t   o b j e c t   h e r ei opo l     ��
�	�  �
  �	  p qrq l     ����  �  �  r sts l     ����  �  �  t uvu j   x |�w� 0 _success _SUCCESSw m   x {xx �yy  O Kv z{z j   } ��|� 0 _failure _FAILURE| m   } �}} �~~  F A I L{ � j   � �� ��  0 _broken _BROKEN� m   � ��� ���  B R O K E N   T E S T� ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  � ���� I      ������� 0 vt100 VT100� ���� o      ���� 0 
formatcode 
formatCode��  ��  � k     �� ��� l      ������  �F@ Returns a magic character sequence that will apply the specified formatting or other control operation in Terminal.app and other VT100 terminal emulators. Multiple codes may be given as semicolon-separated numeric text, e.g. "1;7". Commonly used style codes are:
	
		0 = reset/normal
		1 = bold
		2 = faint
		4 = underline
		5 = blink
		7 = negative
		8 = conceal
		30-37 = foreground colors (black, red, green, yellow, blue, magenta, cyan, white)
		38;5;N = xterm-256 foreground colors (N = 0-255)
		39 = default foreground color
		40-49 = background colors (as for 30-39)
	   � ����   R e t u r n s   a   m a g i c   c h a r a c t e r   s e q u e n c e   t h a t   w i l l   a p p l y   t h e   s p e c i f i e d   f o r m a t t i n g   o r   o t h e r   c o n t r o l   o p e r a t i o n   i n   T e r m i n a l . a p p   a n d   o t h e r   V T 1 0 0   t e r m i n a l   e m u l a t o r s .   M u l t i p l e   c o d e s   m a y   b e   g i v e n   a s   s e m i c o l o n - s e p a r a t e d   n u m e r i c   t e x t ,   e . g .   " 1 ; 7 " .   C o m m o n l y   u s e d   s t y l e   c o d e s   a r e : 
 	 
 	 	 0   =   r e s e t / n o r m a l 
 	 	 1   =   b o l d 
 	 	 2   =   f a i n t 
 	 	 4   =   u n d e r l i n e 
 	 	 5   =   b l i n k 
 	 	 7   =   n e g a t i v e 
 	 	 8   =   c o n c e a l 
 	 	 3 0 - 3 7   =   f o r e g r o u n d   c o l o r s   ( b l a c k ,   r e d ,   g r e e n ,   y e l l o w ,   b l u e ,   m a g e n t a ,   c y a n ,   w h i t e ) 
 	 	 3 8 ; 5 ; N   =   x t e r m - 2 5 6   f o r e g r o u n d   c o l o r s   ( N   =   0 - 2 5 5 ) 
 	 	 3 9   =   d e f a u l t   f o r e g r o u n d   c o l o r 
 	 	 4 0 - 4 9   =   b a c k g r o u n d   c o l o r s   ( a s   f o r   3 0 - 3 9 ) 
 	� ���� L     �� b     ��� b     	��� b     ��� l    ������ 5     �����
�� 
cha � m    ���� 
�� kfrmID  ��  ��  � m    �� ���  [� o    ���� 0 
formatcode 
formatCode� m   	 
�� ���  m��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  � ���� I      ������� "0 _maketestreport _makeTestReport� ��� o      ���� 0 testsuitename testSuiteName� ��� o      ���� "0 testhandlername testHandlerName� ���� o      ���� 0 isstyled isStyled��  ��  � k     U�� ��� Z     I������ o     ���� 0 isstyled isStyled� r    2��� K    0�� ������ 0 n  � I    ������� 0 vt100 VT100� ���� m    ����  ��  ��  � ������ 0 b  � I    ������� 0 vt100 VT100� ���� m    ���� ��  ��  � ������ 0 u  � I    ������� 0 vt100 VT100� ���� m    ���� ��  ��  � ������ 0 r  � I     ������� 0 vt100 VT100� ���� m    ���� ��  ��  � ������ 0 g  � I   ! '������� 0 vt100 VT100� ���� m   " #����  ��  ��  � ������� 0 e  � I   ( .������� 0 vt100 VT100� ���� m   ) *���� "��  ��  ��  � o      ���� 0 vtstyle vtStyle��  � r   5 I��� K   5 G�� ������ 0 n  � m   6 7�� ���  � ������ 0 b  � m   8 9�� ���  � ������ 0 u  � m   : ;�� ���  � ������ 0 r  � m   < =�� ���  � ������ 0 g  � m   > A�� ���  � ������� 0 e  � m   B E�� ���  ��  � o      ���� 0 vtstyle vtStyle� ���� h   J U����� 0 
testreport 
TestReport� k      �� ��� l     ������  � A ; TO DO: get start+end times plus duration in ms from NSDate   � ��� v   T O   D O :   g e t   s t a r t + e n d   t i m e s   p l u s   d u r a t i o n   i n   m s   f r o m   N S D a t e� ��� l     ��������  ��  ��  � ��� l     ���� j     ����� 0 _testresults _testResults� J     ����  � c ] a single test_NAME handler may perform multiple asserts, the result of each is recorded here   � ��� �   a   s i n g l e   t e s t _ N A M E   h a n d l e r   m a y   p e r f o r m   m u l t i p l e   a s s e r t s ,   t h e   r e s u l t   o f   e a c h   i s   r e c o r d e d   h e r e� ��� j    ����� 0 
_dataindex 
_dataIndex� m    ���� �    j    	���� 0 _datasubindex _dataSubIndex m    ����   l     ��������  ��  ��    l     ����   � | TO DO: how much info actually needs to be added here? (especially for succeeded asserts) less is better for obvious reasons    �		 �   T O   D O :   h o w   m u c h   i n f o   a c t u a l l y   n e e d s   t o   b e   a d d e d   h e r e ?   ( e s p e c i a l l y   f o r   s u c c e e d e d   a s s e r t s )   l e s s   i s   b e t t e r   f o r   o b v i o u s   r e a s o n s 

 l     ��������  ��  ��    i  
  I      ������ 0 	addreport 	addReport  o      ���� 0 outcometype outcomeType  o      ���� 0 summarytext summaryText �� o      ���� 0 testdata testData��  ��   l     k       l     ����   ] W outcomeType indicates if test_NAME succeeded, failed, or aborted due to defective test    � �   o u t c o m e T y p e   i n d i c a t e s   i f   t e s t _ N A M E   s u c c e e d e d ,   f a i l e d ,   o r   a b o r t e d   d u e   t o   d e f e c t i v e   t e s t   l     ��!"��  ! Z T summaryText is any additional info passed by `assert�` for inclusion in test report   " �## �   s u m m a r y T e x t   i s   a n y   a d d i t i o n a l   i n f o   p a s s e d   b y   ` a s s e r t & `   f o r   i n c l u s i o n   i n   t e s t   r e p o r t  $%$ l     ��&'��  & � � testData is record of form {expectedResult:�, expectedError:�, actualResult:�, actualError:�}, unused properties should be omitted -- TO DO: make this a key-value list (easier to read, reformat, and render)   ' �((�   t e s t D a t a   i s   r e c o r d   o f   f o r m   { e x p e c t e d R e s u l t : & ,   e x p e c t e d E r r o r : & ,   a c t u a l R e s u l t : & ,   a c t u a l E r r o r : & } ,   u n u s e d   p r o p e r t i e s   s h o u l d   b e   o m i t t e d   - -   T O   D O :   m a k e   t h i s   a   k e y - v a l u e   l i s t   ( e a s i e r   t o   r e a d ,   r e f o r m a t ,   a n d   r e n d e r )% )*) r     +,+ K     -- ��./�� 0 outcometype outcomeType. o    ���� 0 outcometype outcomeType/ ��01�� 0 summarytext summaryText0 o    ���� 0 summarytext summaryText1 ��2���� 0 testdata testData2 o    ���� 0 testdata testData��  , n      343  ;    4 o    ���� 0 _testresults _testResults* 5��5 l   ��67��  6  log result -- DEBUG   7 �88 & l o g   r e s u l t   - -   D E B U G��   � � TO DO: include param for indicating cause (`assert test result` returned wrong result, `assert test error` returned wrong/no error, `test_NAME` errored, etc)    �99<   T O   D O :   i n c l u d e   p a r a m   f o r   i n d i c a t i n g   c a u s e   ( ` a s s e r t   t e s t   r e s u l t `   r e t u r n e d   w r o n g   r e s u l t ,   ` a s s e r t   t e s t   e r r o r `   r e t u r n e d   w r o n g / n o   e r r o r ,   ` t e s t _ N A M E `   e r r o r e d ,   e t c ) :;: l     ��������  ��  ��  ; <=< l     ��>?��  >  -----   ? �@@ 
 - - - - -= ABA l     ��CD��  C�� note: Converting AS objects to their literal representations requires some hoop-jumping: it's impractical for `perform unit test` to format test results on the fly as `osatest` doesn't have an event loop so sending itself AEs while the script is executing might be a tad fiddly. Instead, TestReport just captures everything in its _testResults property and is returned by `perform unit test` on completion (ensuring the captured data stays inside an AS context, so that e.g. application references don't lose their target application as happens when they're packed into an AE as a naked typeObjectSpecifier descriptor). `osaglue` must then repeatedly call the nextRawData() iterator via OSAExecuteEvent, which loads the result value directly into a new scriptValueID; that value's literal representation can then be retrieved via OSADisplay and the resulting text passed back to TestReport's updateRawData(), which reinserts it into the original _testResults data. Once the iterator is exhausted, `osatest` can then call TestReport's renderReport() to assemble all that information (which is now all concatenatable text values) into the final report text, which `osatext` can then print to stdout before doing the whole exercise all over again for the next test handler.   D �EE	�   n o t e :   C o n v e r t i n g   A S   o b j e c t s   t o   t h e i r   l i t e r a l   r e p r e s e n t a t i o n s   r e q u i r e s   s o m e   h o o p - j u m p i n g :   i t ' s   i m p r a c t i c a l   f o r   ` p e r f o r m   u n i t   t e s t `   t o   f o r m a t   t e s t   r e s u l t s   o n   t h e   f l y   a s   ` o s a t e s t `   d o e s n ' t   h a v e   a n   e v e n t   l o o p   s o   s e n d i n g   i t s e l f   A E s   w h i l e   t h e   s c r i p t   i s   e x e c u t i n g   m i g h t   b e   a   t a d   f i d d l y .   I n s t e a d ,   T e s t R e p o r t   j u s t   c a p t u r e s   e v e r y t h i n g   i n   i t s   _ t e s t R e s u l t s   p r o p e r t y   a n d   i s   r e t u r n e d   b y   ` p e r f o r m   u n i t   t e s t `   o n   c o m p l e t i o n   ( e n s u r i n g   t h e   c a p t u r e d   d a t a   s t a y s   i n s i d e   a n   A S   c o n t e x t ,   s o   t h a t   e . g .   a p p l i c a t i o n   r e f e r e n c e s   d o n ' t   l o s e   t h e i r   t a r g e t   a p p l i c a t i o n   a s   h a p p e n s   w h e n   t h e y ' r e   p a c k e d   i n t o   a n   A E   a s   a   n a k e d   t y p e O b j e c t S p e c i f i e r   d e s c r i p t o r ) .   ` o s a g l u e `   m u s t   t h e n   r e p e a t e d l y   c a l l   t h e   n e x t R a w D a t a ( )   i t e r a t o r   v i a   O S A E x e c u t e E v e n t ,   w h i c h   l o a d s   t h e   r e s u l t   v a l u e   d i r e c t l y   i n t o   a   n e w   s c r i p t V a l u e I D ;   t h a t   v a l u e ' s   l i t e r a l   r e p r e s e n t a t i o n   c a n   t h e n   b e   r e t r i e v e d   v i a   O S A D i s p l a y   a n d   t h e   r e s u l t i n g   t e x t   p a s s e d   b a c k   t o   T e s t R e p o r t ' s   u p d a t e R a w D a t a ( ) ,   w h i c h   r e i n s e r t s   i t   i n t o   t h e   o r i g i n a l   _ t e s t R e s u l t s   d a t a .   O n c e   t h e   i t e r a t o r   i s   e x h a u s t e d ,   ` o s a t e s t `   c a n   t h e n   c a l l   T e s t R e p o r t ' s   r e n d e r R e p o r t ( )   t o   a s s e m b l e   a l l   t h a t   i n f o r m a t i o n   ( w h i c h   i s   n o w   a l l   c o n c a t e n a t a b l e   t e x t   v a l u e s )   i n t o   t h e   f i n a l   r e p o r t   t e x t ,   w h i c h   ` o s a t e x t `   c a n   t h e n   p r i n t   t o   s t d o u t   b e f o r e   d o i n g   t h e   w h o l e   e x e r c i s e   a l l   o v e r   a g a i n   f o r   t h e   n e x t   t e s t   h a n d l e r .B FGF l     ��������  ��  ��  G HIH l     ��JK��  J � {{class:error info record, errorText:eText, errorNumber:eNumber, errorValue:eFrom, expectedType:eTo, partialResult:ePartial}   K �LL � { c l a s s : e r r o r   i n f o   r e c o r d ,   e r r o r T e x t : e T e x t ,   e r r o r N u m b e r : e N u m b e r ,   e r r o r V a l u e : e F r o m ,   e x p e c t e d T y p e : e T o ,   p a r t i a l R e s u l t : e P a r t i a l }I MNM j    ��O�� $0 _errorrecordrefs _errorRecordRefsO J    ����  N PQP l     ��������  ��  ��  Q RSR i   TUT I      ����~�� 0 nextrawdata  �  �~  U l   1VWXV k    1YY Z[Z l     �}\]�}  \ g a note: while most of these values can be dealt with natively, for now just toss them to formatter   ] �^^ �   n o t e :   w h i l e   m o s t   o f   t h e s e   v a l u e s   c a n   b e   d e a l t   w i t h   n a t i v e l y ,   f o r   n o w   j u s t   t o s s   t h e m   t o   f o r m a t t e r[ _`_ l     �|ab�|  a D > TO DO: need to see what happens when ocids/optrs are returned   b �cc |   T O   D O :   n e e d   t o   s e e   w h a t   h a p p e n s   w h e n   o c i d s / o p t r s   a r e   r e t u r n e d` ded Z    &fg�{�zf B     hih o     �y�y 0 
_dataindex 
_dataIndexi n   jkj 1   
 �x
�x 
lengk o    
�w�w 0 _testresults _testResultsg k   "ll mnm l   �vop�v  o 4 . currently working way through an error record   p �qq \   c u r r e n t l y   w o r k i n g   w a y   t h r o u g h   a n   e r r o r   r e c o r dn rsr Z    ntu�u�tt >   vwv o    �s�s $0 _errorrecordrefs _errorRecordRefsw J    �r�r  u k    jxx yzy r    '{|{ n    %}~} 1   # %�q
�q 
pcnt~ n    #� 4    #�p�
�p 
cobj� m   ! "�o�o � o     �n�n $0 _errorrecordrefs _errorRecordRefs| o      �m�m 0 	erroritem 	errorItemz ��� Z   ( g���l�k� =  ( /��� o   ( )�j�j 0 	erroritem 	errorItem� o   ) .�i�i 0 _novalue _NoValue� k   2 c�� ��� r   2 ?��� n   2 9��� 1   7 9�h
�h 
rest� o   2 7�g�g $0 _errorrecordrefs _errorRecordRefs� o      �f�f $0 _errorrecordrefs _errorRecordRefs� ��� Z  @ \���e�d� =  @ H��� o   @ E�c�c $0 _errorrecordrefs _errorRecordRefs� J   E G�b�b  � r   K X��� [   K R��� o   K P�a�a 0 _datasubindex _dataSubIndex� m   P Q�`�` � o      �_�_ 0 _datasubindex _dataSubIndex�e  �d  � ��^� L   ] c�� I   ] b�]�\�[�] 0 nextrawdata  �\  �[  �^  �l  �k  � ��Z� L   h j�� o   h i�Y�Y 0 	erroritem 	errorItem�Z  �u  �t  s ��� r   o ��� n   o }��� o   { }�X�X 0 testdata testData� n   o {��� 4   t {�W�
�W 
cobj� o   u z�V�V 0 
_dataindex 
_dataIndex� o   o t�U�U 0 _testresults _testResults� o      �T�T 0 datalist dataList� ��S� Z   �"���R�� B   � ���� o   � ��Q�Q 0 _datasubindex _dataSubIndex� n  � ���� 1   � ��P
�P 
leng� o   � ��O�O 0 datalist dataList� k   � ��� ��� l  � ��N���N  � 4 .	log {"NEXT:", item _dataSubIndex of dataList}   � ��� \ 	 l o g   { " N E X T : " ,   i t e m   _ d a t a S u b I n d e x   o f   d a t a L i s t }� ��� r   � ���� n   � ���� 4   � ��M�
�M 
cobj� m   � ��L�L � n   � ���� 4   � ��K�
�K 
cobj� o   � ��J�J 0 _datasubindex _dataSubIndex� o   � ��I�I 0 datalist dataList� o      �H�H 0 thedata theData� ��� Z   � ����G�F� F   � ���� I   � ��E��D�E 0 istype isType� ��� o   � ��C�C 0 thedata theData� ��B� m   � ��A
�A 
reco�B  �D  � =  � ���� n  � ���� m   � ��@
�@ 
pcls� o   � ��?�? 0 thedata theData� o   � ��>�> $0 _caughterrorinfo _caughtErrorInfo� k   � ��� ��� r   � ���� J   � ��� ��� l 	 � ���=�<� N   � ��� n   � ���� o   � ��;�; 0 errornumber errorNumber� o   � ��:�: 0 thedata theData�=  �<  � ��� N   � ��� n   � ���� o   � ��9�9 0 
errorvalue 
errorValue� o   � ��8�8 0 thedata theData� ��� l 	 � ���7�6� N   � ��� n   � ���� o   � ��5�5 0 expectedtype expectedType� o   � ��4�4 0 thedata theData�7  �6  � ��3� N   � ��� n   � ���� o   � ��2�2 0 partialresult partialResult� o   � ��1�1 0 thedata theData�3  � o      �0�0 $0 _errorrecordrefs _errorRecordRefs� ��� Z  � ����/�.� H   � ��� I   � ��-��,�- 0 istype isType� ��� n   � ���� o   � ��+�+ 0 	errortext 	errorText� o   � ��*�* 0 thedata theData� ��)� m   � ��(
�( 
ctxt�)  �,  � r   � ���� N   � ��� n   � ���� o   � ��'�' 0 	errortext 	errorText� o   � ��&�& 0 thedata theData� n      ���  ;   � �� o   � ��%�% $0 _errorrecordrefs _errorRecordRefs�/  �.  � ��$� L   � ��� I   � ��#�"�!�# 0 nextrawdata  �"  �!  �$  �G  �F  � �� � L   � ��� o   � ��� 0 thedata theData�   �R  � k   �"�� ��� r   �   J   �  [   � o   � ��� 0 
_dataindex 
_dataIndex m   � ��  � m  �� �   J       	
	 o      �� 0 
_dataindex 
_dataIndex
 � o      �� 0 _datasubindex _dataSubIndex�  � � L  " I  !���� 0 nextrawdata  �  �  �  �S  �{  �z  e � l '1 R  '1��
� .ascrerr ****      � ****�   ��
� 
errn m  +.��f�   1 + `osatest` will check for this error number    � V   ` o s a t e s t `   w i l l   c h e c k   f o r   t h i s   e r r o r   n u m b e r�  W ~ x repeatedly called by `osatest` when converting test data to literal representations; once exhausted, returns error 6502   X � �   r e p e a t e d l y   c a l l e d   b y   ` o s a t e s t `   w h e n   c o n v e r t i n g   t e s t   d a t a   t o   l i t e r a l   r e p r e s e n t a t i o n s ;   o n c e   e x h a u s t e d ,   r e t u r n s   e r r o r   6 5 0 2S  l     ����  �  �    i    I      �
�	�
 0 updaterawdata   � o      �� 0 literaltext literalText�  �	   l    p  k     p!! "#" Z     m$%�&$ =    '(' o     �� $0 _errorrecordrefs _errorRecordRefs( J    ��  % k    3)) *+* l   �,-�  , # log {"UPDATE:", _testResults}   - �.. : l o g   { " U P D A T E : " ,   _ t e s t R e s u l t s }+ /0/ r    %121 o    �� 0 literaltext literalText2 n      343 4   ! $�5
� 
cobj5 m   " #� �  4 n    !676 4    !��8
�� 
cobj8 o     ���� 0 _datasubindex _dataSubIndex7 n    9:9 o    ���� 0 testdata testData: n    ;<; 4    ��=
�� 
cobj= o    ���� 0 
_dataindex 
_dataIndex< o    ���� 0 _testresults _testResults0 >��> r   & 3?@? [   & -ABA o   & +���� 0 _datasubindex _dataSubIndexB m   + ,���� @ o      ���� 0 _datasubindex _dataSubIndex��  �  & k   6 mCC DED r   6 BFGF o   6 7���� 0 literaltext literalTextG n      HIH 1   ? A��
�� 
pcntI n   7 ?JKJ 4  < ?��L
�� 
cobjL m   = >���� K o   7 <���� $0 _errorrecordrefs _errorRecordRefsE MNM r   C POPO n   C JQRQ 1   H J��
�� 
restR o   C H���� $0 _errorrecordrefs _errorRecordRefsP o      ���� $0 _errorrecordrefs _errorRecordRefsN S��S Z  Q mTU����T =  Q YVWV o   Q V���� $0 _errorrecordrefs _errorRecordRefsW J   V X����  U r   \ iXYX [   \ cZ[Z o   \ a���� 0 _datasubindex _dataSubIndex[ m   a b���� Y o      ���� 0 _datasubindex _dataSubIndex��  ��  ��  # \��\ L   n p����  ��  a[ called by `osatest` to reinsert the raw data's literal representation; must be called after each nextRawData() (if formatting fails for any reason, use a placeholder, e.g. "�object�") -- TO DO: might be better to pass a boolean parameter along with literalText that indicates if the conversion failed; that way, reporter can decide what to insert     �]]�   c a l l e d   b y   ` o s a t e s t `   t o   r e i n s e r t   t h e   r a w   d a t a ' s   l i t e r a l   r e p r e s e n t a t i o n ;   m u s t   b e   c a l l e d   a f t e r   e a c h   n e x t R a w D a t a ( )   ( i f   f o r m a t t i n g   f a i l s   f o r   a n y   r e a s o n ,   u s e   a   p l a c e h o l d e r ,   e . g .   " � o b j e c t � " )   - -   T O   D O :   m i g h t   b e   b e t t e r   t o   p a s s   a   b o o l e a n   p a r a m e t e r   a l o n g   w i t h   l i t e r a l T e x t   t h a t   i n d i c a t e s   i f   t h e   c o n v e r s i o n   f a i l e d ;   t h a t   w a y ,   r e p o r t e r   c a n   d e c i d e   w h a t   t o   i n s e r t ^_^ l     ��������  ��  ��  _ `a` l     ��������  ��  ��  a bcb l     ��������  ��  ��  c ded i   fgf I      �������� 0 renderreport  ��  ��  g l    hijh l    klmk L     nn m     oo �pp $ < < < T E S T   R E S U L T S > > >l M G TO DO: _testResults data should be formatted as nicely structured text   m �qq �   T O   D O :   _ t e s t R e s u l t s   d a t a   s h o u l d   b e   f o r m a t t e d   a s   n i c e l y   s t r u c t u r e d   t e x ti m g construct final report text; also needs to return ok/fail/broke status flag for generating final tally   j �rr �   c o n s t r u c t   f i n a l   r e p o r t   t e x t ;   a l s o   n e e d s   t o   r e t u r n   o k / f a i l / b r o k e   s t a t u s   f l a g   f o r   g e n e r a t i n g   f i n a l   t a l l ye s��s l     ��������  ��  ��  ��  ��  � tut l     ��������  ��  ��  u vwv l     ��xy��  x  -----   y �zz 
 - - - - -w {|{ l     ��}~��  }   run a single test   ~ � $   r u n   a   s i n g l e   t e s t| ��� l     ��������  ��  ��  � ��� i  � ���� I      ������� (0 sanitizeidentifier sanitizeIdentifier� ���� o      ���� 0 aname aName��  ��  � P     s���� k    r�� ��� Z   ������� =   ��� o    ���� 0 aname aName� m    �� ���  � L    �� m    �� ���  | |��  ��  � ��� r    ��� m    �� ���  � o      ���� 0 res  � ��� r    ��� m    �� ��� 6 a b c d e f g h i j k l m n o p q r s t u v w x y z _� o      ���� 0 
legalchars 
legalChars� ��� r    ��� m    ��
�� boovfals� o      ���� 0 usepipes usePipes� ��� X    _����� k   . Z�� ��� Z   . P������� H   . 4�� E  . 3��� o   . /���� 0 
legalchars 
legalChars� n  / 2��� 1   0 2��
�� 
pcnt� o   / 0���� 0 charref charRef� k   7 L�� ��� r   7 :��� m   7 8��
�� boovtrue� o      ���� 0 usepipes usePipes� ���� Z  ; L������� E  ; @��� m   ; <�� ���  \ |� n  < ?��� 1   = ?��
�� 
pcnt� o   < =���� 0 charref charRef� r   C H��� b   C F��� m   C D�� ���  \� o   D E���� 0 charref charRef� o      ���� 0 charref charRef��  ��  ��  ��  ��  � ��� r   Q V��� b   Q T��� o   Q R���� 0 res  � o   R S���� 0 charref charRef� o      ���� 0 res  � ���� r   W Z��� m   W X�� ��� J a b c d e f g h i j k l m n o p q r s t u v w x y z _ 1 2 3 4 5 6 7 8 9 0� o      ���� 0 
legalchars 
legalChars��  �� 0 charref charRef� o   ! "���� 0 aname aName� ��� Z  ` o������� o   ` a���� 0 usepipes usePipes� r   d k��� b   d i��� b   d g��� m   d e�� ���  |� o   e f���� 0 res  � m   g h�� ���  |� o      ���� 0 res  ��  ��  � ���� L   p r�� o   p q���� 0 res  ��  � ���
�� consdiac� ���
�� conshyph� ���
�� conspunc� ����
�� conswhit��  � ���
�� conscase� ����
�� consnume��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  � ���� I      ������� "0 _makecallobject _makeCallObject� ��� o      ���� 0 handlername handlerName� ���� o      ����  0 parametercount parameterCount��  ��  � k     S�� ��� Z     4������ ?     ��� o     ����  0 parametercount parameterCount� m    ����  � k    .�� ��� r    	� � m     �    o      ���� 0 args  �  Y   
  ���� r    	 b    

 b     o    ���� 0 args   m     � 2 ,   p a r a m e t e r O b j e c t ' s   i t e m   o    ���� 0 i  	 o      ���� 0 args  �� 0 i   m    ����  o    ����  0 parametercount parameterCount��   �� r   ! . n   ! , 7  " ,��
�� 
ctxt m   & (����  m   ) +������ o   ! "���� 0 args   o      ���� 0 args  ��  ��  � r   1 4 m   1 2 �   o      ���� 0 args  � � l  5 S L   5 S I  5 R�~ �}
�~ .sysodsct****        scpt  b   5 N!"! b   5 L#$# b   5 J%&% b   5 H'(' b   5 A)*) b   5 ?+,+ m   5 6-- �.. 0 o n   r u n 
 	 	 	 	 	 	 	 	 	 	 s c r i p t  , I   6 >�|/�{�| (0 sanitizeidentifier sanitizeIdentifier/ 0�z0 b   7 :121 m   7 833 �44  C a l l O b j e c t _2 o   8 9�y�y 0 handlername handlerName�z  �{  * m   ? @55 �66 � 
 	 	 	 	 	 	 	 	 	 	 	 o n   d o T e s t ( s u i t e O b j e c t ,   p a r a m e t e r O b j e c t ) 
 	 	 	 	 	 	 	 	 	 	 	 	 r e t u r n   s u i t e O b j e c t ' s  ( I   A G�x7�w�x (0 sanitizeidentifier sanitizeIdentifier7 8�v8 o   B C�u�u 0 handlername handlerName�v  �w  & m   H I99 �::  ($ o   J K�t�t 0 args  " m   L M;; �<< t ) 
 	 	 	 	 	 	 	 	 	 	 	 e n d   r u n 
 	 	 	 	 	 	 	 	 	 	 e n d   s c r i p t 
 	 	 	 	 	 	 	 	 	 e n d   r u n�}   [ U TO DO: any benefit to creating this object this via OSAKit rather than `run script`?    �== �   T O   D O :   a n y   b e n e f i t   t o   c r e a t i n g   t h i s   o b j e c t   t h i s   v i a   O S A K i t   r a t h e r   t h a n   ` r u n   s c r i p t ` ?�  � >?> l     �s�r�q�s  �r  �q  ? @A@ l     �pBC�p  B  -----   C �DD 
 - - - - -A EFE l     �o�n�m�o  �n  �m  F GHG l     IJKI j   � ��lL�l $0 _testhandlername _testHandlerNameL m   � ��k
�k 
msngJ R L used to generate default `call_NAME` handler name for a `test_NAME` handler   K �MM �   u s e d   t o   g e n e r a t e   d e f a u l t   ` c a l l _ N A M E `   h a n d l e r   n a m e   f o r   a   ` t e s t _ N A M E `   h a n d l e rH NON l     �j�i�h�j  �i  �h  O PQP i  � �RSR I      �gT�f�g 0 __performunittestforsuite__  T UVU o      �e�e 0 suiteobject suiteObjectV W�dW J      XX YZY o      �c�c 0 	suitename 	suiteNameZ [\[ o      �b�b 0 handlername handlerName\ ]^] o      �a�a 0 handlerkeys handlerKeys^ _�`_ o      �_�_ 0 isstyled isStyled�`  �d  �f  S k    (`` aba l      �^cd�^  cQK
		suiteObject : script -- test suite object
		suiteName : text -- test suite name, for reporting use
		handlerName : text -- name of the test suite handler to call
		allHandlerNames : list of text -- all handler names in this test suite; used to determine which if any fixture methods (setUp, tearDown, etc.) need to be called
		isStyled : boolean -- if true, the returned report will include special formatting codes (bold, underline) to improve presentation in Terminal.app and other VT100 emulators; use false if you intend to use this text elsewhere
		Result: script -- TestReport
	   d �ee� 
 	 	 s u i t e O b j e c t   :   s c r i p t   - -   t e s t   s u i t e   o b j e c t 
 	 	 s u i t e N a m e   :   t e x t   - -   t e s t   s u i t e   n a m e ,   f o r   r e p o r t i n g   u s e 
 	 	 h a n d l e r N a m e   :   t e x t   - -   n a m e   o f   t h e   t e s t   s u i t e   h a n d l e r   t o   c a l l 
 	 	 a l l H a n d l e r N a m e s   :   l i s t   o f   t e x t   - -   a l l   h a n d l e r   n a m e s   i n   t h i s   t e s t   s u i t e ;   u s e d   t o   d e t e r m i n e   w h i c h   i f   a n y   f i x t u r e   m e t h o d s   ( s e t U p ,   t e a r D o w n ,   e t c . )   n e e d   t o   b e   c a l l e d 
 	 	 i s S t y l e d   :   b o o l e a n   - -   i f   t r u e ,   t h e   r e t u r n e d   r e p o r t   w i l l   i n c l u d e   s p e c i a l   f o r m a t t i n g   c o d e s   ( b o l d ,   u n d e r l i n e )   t o   i m p r o v e   p r e s e n t a t i o n   i n   T e r m i n a l . a p p   a n d   o t h e r   V T 1 0 0   e m u l a t o r s ;   u s e   f a l s e   i f   y o u   i n t e n d   t o   u s e   t h i s   t e x t   e l s e w h e r e 
 	 	 R e s u l t :   s c r i p t   - -   T e s t R e p o r t 
 	b fgf l     �]�\�[�]  �\  �[  g hih l     �Zjk�Z  j  		return 3   k �ll  	 r e t u r n   3i mnm l     �Yop�Y  o  	log {suiteObject}   p �qq $ 	 l o g   { s u i t e O b j e c t }n rsr r     tut o     �X�X 0 suiteobject suiteObjectu o      �W�W $0 _testsuiteobject _testSuiteObjects vwv r    xyx o    	�V�V 0 handlername handlerNamey o      �U�U $0 _testhandlername _testHandlerNamew z{z r    |}| I    �T~�S�T "0 _maketestreport _makeTestReport~ � o    �R�R 0 	suitename 	suiteName� ��� o    �Q�Q 0 handlername handlerName� ��P� o    �O�O 0 isstyled isStyled�P  �S  } o      �N�N 0 _testreport _testReport{ ��� Q    p���� Z  " 3���M�L� E   " '��� o   " #�K�K 0 handlerkeys handlerKeys� J   # &�� ��J� m   # $�� ��� 
 s e t u p�J  � n  * /��� I   + /�I�H�G�I 0 setup setUp�H  �G  � o   * +�F�F 0 suiteobject suiteObject�M  �L  � R      �E��
�E .ascrerr ****      � ****� o      �D�D 0 etext eText� �C��
�C 
errn� o      �B�B 0 enumber eNumber� �A��
�A 
erob� o      �@�@ 0 efrom eFrom� �?��
�? 
errt� o      �>�> 
0 eto eTo� �=��<
�= 
ptlr� o      �;�; 0 epartial ePartial�<  � k   ; p�� ��� n  ; a��� I   @ a�:��9�: 0 	addreport 	addReport� ��� o   @ E�8�8 0 _broken _BROKEN� ��� o   E F�7�7 0 summarytext summaryText� ��6� J   F ]�� ��5� J   F [�� ��� m   F G�� ���  b r o k e n   s e t U p� ��4� K   G Y�� �3��
�3 
pcls� o   H M�2�2 $0 _caughterrorinfo _caughtErrorInfo� �1���1 0 	errortext 	errorText� o   N O�0�0 0 etext eText� �/���/ 0 errornumber errorNumber� o   P Q�.�. 0 enumber eNumber� �-���- 0 
errorvalue 
errorValue� o   R S�,�, 0 efrom eFrom� �+���+ 0 expectedtype expectedType� o   T U�*�* 
0 eto eTo� �)��(�) 0 partialresult partialResult� o   V W�'�' 0 epartial ePartial�(  �4  �5  �6  �9  � o   ; @�&�& 0 _testreport _testReport� ��� r   b i��� m   b c�%
�% 
msng� o      �$�$ $0 _testsuiteobject _testSuiteObject� ��#� L   j p�� o   j o�"�" 0 _testreport _testReport�#  � ��� r   q z��� I   q x�!�� �! "0 _makecallobject _makeCallObject� ��� o   r s�� 0 handlername handlerName� ��� m   s t��  �  �   � o      �� 0 
callobject 
callObject� ��� Q   { ����� n  ~ ���� I    ����� 0 dotest doTest� ��� o    ��� 0 suiteobject suiteObject� ��� m   � ��
� 
msng�  �  � o   ~ �� 0 
callobject 
callObject� R      ���
� .ascrerr ****      � ****� o      �� 0 etext eText� ���
� 
errn� o      �� 0 enumber eNumber� ���
� 
erob� o      �� 0 efrom eFrom� ���
� 
errt� o      �� 
0 eto eTo� ���
� 
ptlr� o      �� 0 epartial ePartial�  � l  � ����� Z   � ����
�	� H   � ��� l  � ����� F   � ���� =   � ���� o   � ��� 0 enumber eNumber� o   � ��� 00 _abortedassertionerror _AbortedAssertionError� =  � ���� o   � ��� 0 efrom eFrom� o   � ��� 00 _abortedassertiontoken _AbortedAssertionToken�  �  � l  � ����� l  � ����� n  � ���� I   � ����� 0 	addreport 	addReport� ��� o   � �� �  0 _failure _FAILURE� ��� o   � ����� 0 etext eText� ���� J   � ��� ���� J   � ��� ��� m   � ��� ���   u n e x p e c t e d   e r r o r� ���� K   � �   ��
�� 
pcls o   � ����� $0 _caughterrorinfo _caughtErrorInfo ���� 0 	errortext 	errorText o   � ����� 0 etext eText ���� 0 errornumber errorNumber o   � ����� 0 enumber eNumber ���� 0 
errorvalue 
errorValue o   � ����� 0 efrom eFrom ��	
�� 0 expectedtype expectedType	 o   � ����� 
0 eto eTo
 ������ 0 partialresult partialResult o   � ����� 0 epartial ePartial��  ��  ��  ��  �  � o   � ����� 0 _testreport _testReport� � � note: without stack trace support, there's no way to distinguish an error raised by the code being tested versus an error caused by a bug in the test   � �,   n o t e :   w i t h o u t   s t a c k   t r a c e   s u p p o r t ,   t h e r e ' s   n o   w a y   t o   d i s t i n g u i s h   a n   e r r o r   r a i s e d   b y   t h e   c o d e   b e i n g   t e s t e d   v e r s u s   a n   e r r o r   c a u s e d   b y   a   b u g   i n   t h e   t e s t� � � check if failure was already reported, and this is the subsequent abort, in which case ignore; if not, it's an error in either the test_NAME handler or the code being tested, so report it   � �x   c h e c k   i f   f a i l u r e   w a s   a l r e a d y   r e p o r t e d ,   a n d   t h i s   i s   t h e   s u b s e q u e n t   a b o r t ,   i n   w h i c h   c a s e   i g n o r e ;   i f   n o t ,   i t ' s   a n   e r r o r   i n   e i t h e r   t h e   t e s t _ N A M E   h a n d l e r   o r   t h e   c o d e   b e i n g   t e s t e d ,   s o   r e p o r t   i t�
  �	  �   test failed   � �    t e s t   f a i l e d�  Q   � Z  � ����� E   � � o   � ����� 0 handlerkeys handlerKeys J   � � �� m   � � �  t e a r d o w n��   n  � � I   � ��������� 0 teardown tearDown��  ��   o   � ����� 0 suiteobject suiteObject��  ��   R      ��
�� .ascrerr ****      � **** o      ���� 0 etext eText �� !
�� 
errn  o      ���� 0 enumber eNumber! ��"#
�� 
erob" o      ���� 0 efrom eFrom# ��$%
�� 
errt$ o      ���� 
0 eto eTo% ��&��
�� 
ptlr& o      ���� 0 epartial ePartial��   n  �'(' I   ���)���� 0 	addreport 	addReport) *+* o   � ����� 0 _broken _BROKEN+ ,-, o   � ����� 0 summarytext summaryText- .��. J   �// 0��0 J   �11 232 m   � �44 �55  b r o k e n   t e a r D o w n3 6��6 K   �77 ��89
�� 
pcls8 o   ���� $0 _caughterrorinfo _caughtErrorInfo9 ��:;�� 0 	errortext 	errorText: o  ���� 0 etext eText; ��<=�� 0 errornumber errorNumber< o  	���� 0 enumber eNumber= ��>?�� 0 
errorvalue 
errorValue> o  
���� 0 efrom eFrom? ��@A�� 0 expectedtype expectedType@ o  ���� 
0 eto eToA ��B���� 0 partialresult partialResultB o  ���� 0 epartial ePartial��  ��  ��  ��  ��  ( o   � ����� 0 _testreport _testReport CDC r  !EFE m  ��
�� 
msngF o      ���� $0 _testsuiteobject _testSuiteObjectD G��G l "(HIJH L  "(KK o  "'���� 0 _testreport _testReportI�{ TO DO: wrapping all the test data (result values, error info, status, etc) in a script object and returning that preserves AS context info and AS types across the AE bridge; the script object can then be loaded into a new OSAID and its methods called to extract each bit of data in turn for formatting and final message generation  (caveat not sure what ocids and optrs will do)   J �LL�   T O   D O :   w r a p p i n g   a l l   t h e   t e s t   d a t a   ( r e s u l t   v a l u e s ,   e r r o r   i n f o ,   s t a t u s ,   e t c )   i n   a   s c r i p t   o b j e c t   a n d   r e t u r n i n g   t h a t   p r e s e r v e s   A S   c o n t e x t   i n f o   a n d   A S   t y p e s   a c r o s s   t h e   A E   b r i d g e ;   t h e   s c r i p t   o b j e c t   c a n   t h e n   b e   l o a d e d   i n t o   a   n e w   O S A I D   a n d   i t s   m e t h o d s   c a l l e d   t o   e x t r a c t   e a c h   b i t   o f   d a t a   i n   t u r n   f o r   f o r m a t t i n g   a n d   f i n a l   m e s s a g e   g e n e r a t i o n     ( c a v e a t   n o t   s u r e   w h a t   o c i d s   a n d   o p t r s   w i l l   d o )��  Q MNM l     ��������  ��  ��  N OPO l     ��������  ��  ��  P QRQ l     ��ST��  S J D--------------------------------------------------------------------   T �UU � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -R VWV l     ��XY��  X   Unit Test Assertions   Y �ZZ *   U n i t   T e s t   A s s e r t i o n sW [\[ l     ��������  ��  ��  \ ]^] i  � �_`_ I      ��a���� <0 _returnassertresultsucceeded _returnAssertResultSucceededa bcb o      ���� 0 summarytext summaryTextc d��d o      ����  0 expectedresult expectedResult��  ��  ` l    efge k     hh iji n    klk I    ��m���� 0 	addreport 	addReportm non o    
���� 0 _success _SUCCESSo pqp o   
 ���� 0 summarytext summaryTextq r��r J    ss t��t J    uu vwv m    xx �yy  e x p e c t e d   r e s u l tw z��z o    ����  0 expectedresult expectedResult��  ��  ��  ��  l o     ���� 0 _testreport _testReportj {��{ L    ����  ��  f   returned expected result   g �|| 2   r e t u r n e d   e x p e c t e d   r e s u l t^ }~} l     ��������  ��  ��  ~ � i  � ���� I      ������� 40 _raiseassertresultfailed _raiseAssertResultFailed� ��� o      ���� 0 summarytext summaryText� ��� o      ����  0 expectedresult expectedResult� ���� o      ���� 0 actualresult actualResult��  ��  � l    *���� k     *�� ��� n    ��� I    ������� 0 	addreport 	addReport� ��� o    
���� 0 _failure _FAILURE� ��� o   
 ���� 0 summarytext summaryText� ���� J    �� ��� J    �� ��� m    �� ���  e x p e c t e d   r e s u l t� ���� o    ����  0 expectedresult expectedResult��  � ���� J    �� ��� m    �� ���  a c t u a l   r e s u l t� ���� o    ���� 0 actualresult actualResult��  ��  ��  ��  � o     ���� 0 _testreport _testReport� ���� R    *�����
�� .ascrerr ****      � ****��  � ����
�� 
errn� o    !���� 00 _abortedassertionerror _AbortedAssertionError� �����
�� 
erob� o   " '���� 00 _abortedassertiontoken _AbortedAssertionToken��  ��  � L F returned unexpected result (failures due to errors are caught sooner)   � ��� �   r e t u r n e d   u n e x p e c t e d   r e s u l t   ( f a i l u r e s   d u e   t o   e r r o r s   a r e   c a u g h t   s o o n e r )� ��� l     ��������  ��  ��  � ��� i  � ���� I      ������� :0 _returnasserterrorsucceeded _returnAssertErrorSucceeded� ��� o      ���� 0 summarytext summaryText� ���� o      ���� 0 expectederror expectedError��  ��  � l    ���� k     �� ��� n    ��� I    ������� 0 	addreport 	addReport� ��� o    
���� 0 _success _SUCCESS� ��� o   
 �� 0 summarytext summaryText� ��~� J    �� ��}� J    �� ��� m    �� ���  e x p e c t e d   e r r o r� ��|� o    �{�{ 0 expectederror expectedError�|  �}  �~  ��  � o     �z�z 0 _testreport _testReport� ��y� L    �x�x  �y  �   raised expected error   � ��� ,   r a i s e d   e x p e c t e d   e r r o r� ��� l     �w�v�u�w  �v  �u  � ��� i  � ���� I      �t��s�t 20 _raiseasserterrorfailed _raiseAssertErrorFailed� ��� o      �r�r 0 summarytext summaryText� ��� o      �q�q 0 expectederror expectedError� ��� o      �p�p 0 actualerror actualError� ��o� o      �n�n 0 actualresult actualResult�o  �s  � l    V���� k     V�� ��� r     ��� J     �� ��m� J     �� ��� m     �� ���  e x p e c t e d   e r r o r� ��l� o    �k�k 0 expectederror expectedError�l  �m  � o      �j�j 0 testdata testData� ��� Z  	 ���i�h� >  	 ��� o   	 
�g�g 0 actualerror actualError� o   
 �f�f 0 _novalue _NoValue� r    ��� J    �� ��� m    �� ���  a c t u a l   e r r o r� ��e� o    �d�d 0 actualerror actualError�e  � n      ���  ;    � o    �c�c 0 testdata testData�i  �h  � ��� Z   4� �b�a� >   & o     �`�` 0 actualresult actualResult o     %�_�_ 0 _novalue _NoValue  r   ) 0 J   ) -  m   ) * �		 " u n e x p e c t e d   r e s u l t 
�^
 o   * +�]�] 0 actualresult actualResult�^   n        ;   . / o   - .�\�\ 0 testdata testData�b  �a  �  n  5 E I   : E�[�Z�[ 0 	addreport 	addReport  o   : ?�Y�Y 0 _failure _FAILURE  o   ? @�X�X 0 summarytext summaryText �W o   @ A�V�V 0 testdata testData�W  �Z   o   5 :�U�U 0 _testreport _testReport �T R   F V�S�R
�S .ascrerr ****      � ****�R   �Q
�Q 
errn o   H M�P�P 00 _abortedassertionerror _AbortedAssertionError �O�N
�O 
erob o   N S�M�M 00 _abortedassertiontoken _AbortedAssertionToken�N  �T  � [ U raised wrong error or didn't raise an error; pass _NoValue to indicate missing value   � � �   r a i s e d   w r o n g   e r r o r   o r   d i d n ' t   r a i s e   a n   e r r o r ;   p a s s   _ N o V a l u e   t o   i n d i c a t e   m i s s i n g   v a l u e�  l     �L�K�J�L  �K  �J     i  � �!"! I      �I#�H�I .0 _raisedefectiveassert _raiseDefectiveAssert# $%$ o      �G�G 0 summarytext summaryText% &'& o      �F�F 0 etext eText' ()( o      �E�E 0 enumber eNumber) *+* o      �D�D 0 efrom eFrom+ ,-, o      �C�C 
0 eto eTo- .�B. o      �A�A 0 epartial ePartial�B  �H  " k     7// 010 n    &232 I    &�@4�?�@ 0 	addreport 	addReport4 565 o    
�>�> 0 _broken _BROKEN6 787 o   
 �=�= 0 summarytext summaryText8 9�<9 J    ":: ;�;; J     << =>= m    ?? �@@  b r o k e n   a s s e r t> A�:A K    BB �9CD
�9 
pclsC o    �8�8 $0 _caughterrorinfo _caughtErrorInfoD �7EF�7 0 	errortext 	errorTextE o    �6�6 0 etext eTextF �5GH�5 0 errornumber errorNumberG o    �4�4 0 enumber eNumberH �3IJ�3 0 
errorvalue 
errorValueI o    �2�2 0 efrom eFromJ �1KL�1 0 expectedtype expectedTypeK o    �0�0 
0 eto eToL �/M�.�/ 0 partialresult partialResultM o    �-�- 0 epartial ePartial�.  �:  �;  �<  �?  3 o     �,�, 0 _testreport _testReport1 N�+N R   ' 7�*�)O
�* .ascrerr ****      � ****�)  O �(PQ
�( 
errnP o   ) .�'�' 00 _abortedassertionerror _AbortedAssertionErrorQ �&R�%
�& 
erobR o   / 4�$�$ 00 _abortedassertiontoken _AbortedAssertionToken�%  �+    STS l     �#�"�!�#  �"  �!  T UVU l     � ���   �  �  V WXW l     �YZ�  Y  -----   Z �[[ 
 - - - - -X \]\ l     ����  �  �  ] ^_^ l     �`a�  ` � � TO DO: if `note` is omitted (and even if it isn't) could do with passing a better description of the `assert...` command to TestReport   a �bb   T O   D O :   i f   ` n o t e `   i s   o m i t t e d   ( a n d   e v e n   i f   i t   i s n ' t )   c o u l d   d o   w i t h   p a s s i n g   a   b e t t e r   d e s c r i p t i o n   o f   t h e   ` a s s e r t . . . `   c o m m a n d   t o   T e s t R e p o r t_ cdc l     ����  �  �  d efe l     �gh�  g o i TO DO: rename these `assert test result`, `assert test error` to help reduce risk of keyword collisions?   h �ii �   T O   D O :   r e n a m e   t h e s e   ` a s s e r t   t e s t   r e s u l t ` ,   ` a s s e r t   t e s t   e r r o r `   t o   h e l p   r e d u c e   r i s k   o f   k e y w o r d   c o l l i s i o n s ?f jkj l     ����  �  �  k lml i  � �non I     ��p
� .���:AsRenull��� ��� null�  p �qr
� 
Valuq o      �� 0 actualresult actualResultr �st
� 
Equas o      ��  0 expectedresult expectedResultt �uv
� 
Summu |�
�	w�x�
  �	  w o      �� 0 summarytext summaryText�  x l     y��y m      zz �{{  �  �  v �|�
� 
FCmp| |��}� ~�  �  } o      ���� $0 hasrealtolerance hasRealTolerance�   ~ l     ���� m      ��
�� boovfals��  ��  �  o k     ��� ��� Z    ������� =    ��� o     ���� $0 _testsuiteobject _testSuiteObject� m    ��
�� 
msng� R   
 ����
�� .ascrerr ****      � ****� m    �� ��� d C a n n o t    a s s e r t   t e s t   r e s u l t    o u t s i d e   o f   u n i t   t e s t s .� �����
�� 
errn� m    �����T��  ��  ��  � ���� P    ����� Q    ����� k    ��� ��� r    *��� n   (��� I   " (������� "0 astextparameter asTextParameter� ��� o   " #���� 0 summarytext summaryText� ���� m   # $�� ���  s u m m a r y��  ��  � o    "���� 0 _supportlib _supportLib� o      ���� 0 summarytext summaryText� ��� r   + 8��� n  + 6��� I   0 6������� (0 asbooleanparameter asBooleanParameter� ��� o   0 1���� $0 hasrealtolerance hasRealTolerance� ���� m   1 2�� ���  r e a l   c o m p a r i s o n��  ��  � o   + 0���� 0 _supportlib _supportLib� o      ���� $0 hasrealtolerance hasRealTolerance� ��� Z  9 h������� F   9 G��� o   9 :���� $0 hasrealtolerance hasRealTolerance� H   = E�� I   = D������� 0 istype isType� ��� o   > ?����  0 expectedresult expectedResult� ���� m   ? @��
�� 
nmbr��  ��  � R   J d����
�� .ascrerr ****      � ****� b   V c��� b   V _��� m   V Y�� ��� � B a d    i s    p a r a m e t e r   ( r e a l   c o m p a r i s o n   r e q u i r e s   n u m e r i c    i s    p a r a m e t e r   b u t   r e c e i v e d  � n  Y ^��� m   Z ^��
�� 
pcls� o   Y Z����  0 expectedresult expectedResult� m   _ b�� ���  )� ����
�� 
errn� m   L M�����Y� ����
�� 
erob� o   N O����  0 expectedresult expectedResult� �����
�� 
errt� m   P S��
�� 
doub��  ��  ��  � ��� Z   i ������� o   i j���� $0 hasrealtolerance hasRealTolerance� r   m ���� F   m ���� l  m v������ A   m v��� \   m t��� o   m n���� 0 actualresult actualResult� o   n s���� 0 _isequaldelta _isEqualDelta� o   t u����  0 expectedresult expectedResult��  ��  � l  y ������� ?   y ���� [   y ���� o   y z���� 0 actualresult actualResult� o   z ���� 0 _isequaldelta _isEqualDelta� o   � �����  0 expectedresult expectedResult��  ��  � o      ���� 0 isequal isEqual��  � r   � ���� =  � ���� o   � ����� 0 actualresult actualResult� o   � �����  0 expectedresult expectedResult� o      ���� 0 isequal isEqual� ��� Z  � �������� o   � ����� 0 isequal isEqual� L   � ��� I   � �������� <0 _returnassertresultsucceeded _returnAssertResultSucceeded� ��� o   � ����� 0 summarytext summaryText� ���� o   � �����  0 expectedresult expectedResult��  ��  ��  ��  � ���� I   � �������� 40 _raiseassertresultfailed _raiseAssertResultFailed� ��� o   � ����� 0 summarytext summaryText� ��� o   � ����� 0 actualresult actualResult� ���� o   � �����  0 expectedresult expectedResult��  ��  ��  � R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� ����
�� 
errt� o      ���� 
0 eto eTo� �����
�� 
ptlr� o      ���� 0 epartial ePartial��  � I   � �������� .0 _raisedefectiveassert _raiseDefectiveAssert� ��� o   � ����� 0 summarytext summaryText� ��� b   � ���� m   � ��� �   8 C a n  t    a s s e r t   t e s t   r e s u l t  :  � o   � ����� 0 etext eText�  o   � ����� 0 enumber eNumber  o   � ����� 0 efrom eFrom  o   � ����� 
0 eto eTo �� o   � ����� 0 epartial ePartial��  ��  � ��
�� conscase ��	
�� consdiac	 ��

�� conshyph
 ��
�� conspunc ����
�� conswhit��  � ����
�� consnume��  ��  m  l     ��������  ��  ��    l     ��������  ��  ��    i  � � I     ����
�� .���:AsErnull��� ��� null��   ��
�� 
Hand |��������  ��   o      ���� "0 callhandlername callHandlerName��   l     ���� m       �  ��  ��   ��
�� 
Args |��������  ��   o      ����  0 parametervalue parameterValue��   l      ����  m      ��
�� 
���!��  ��   ��!"
�� 
Equa! o      ���� 0 expectederror expectedError" ��#�
�� 
Summ# |�~�}$�|%�~  �}  $ o      �{�{ 0 summarytext summaryText�|  % l     &�z�y& m      '' �((  �z  �y  �   k    7)) *+* Z    ,-�x�w, =    ./. o     �v�v $0 _testsuiteobject _testSuiteObject/ m    �u
�u 
msng- R   
 �t01
�t .ascrerr ****      � ****0 m    22 �33 b C a n n o t    a s s e r t   t e s t   e r r o r    o u t s i d e   o f   u n i t   t e s t s .1 �s4�r
�s 
errn4 m    �q�q�T�r  �x  �w  + 5�p5 P   76786 k   699 :;: Q   <=>< k   �?? @A@ r    *BCB n   (DED I   " (�oF�n�o "0 astextparameter asTextParameterF GHG o   " #�m�m "0 callhandlername callHandlerNameH I�lI m   # $JJ �KK  i n�l  �n  E o    "�k�k 0 _supportlib _supportLibC o      �j�j "0 callhandlername callHandlerNameA LML r   + 8NON n  + 6PQP I   0 6�iR�h�i &0 asrecordparameter asRecordParameterR STS o   0 1�g�g 0 expectederror expectedErrorT U�fU m   1 2VV �WW  i s�f  �h  Q o   + 0�e�e 0 _supportlib _supportLibO o      �d�d 0 expectederror expectedErrorM XYX l  9 9�cZ[�c  Z W Q make sure expectedError contains at least one valid property and no invalid ones   [ �\\ �   m a k e   s u r e   e x p e c t e d E r r o r   c o n t a i n s   a t   l e a s t   o n e   v a l i d   p r o p e r t y   a n d   n o   i n v a l i d   o n e sY ]^] Z  9 Q_`�b�a_ =   9 >aba n  9 <cdc 1   : <�`
�` 
lengd o   9 :�_�_ 0 expectederror expectedErrorb m   < =�^�^  ` R   A M�]ef
�] .ascrerr ****      � ****e m   I Lgg �hh p I n v a l i d    i s    p a r a m e t e r   ( r e c o r d   c o n t a i n e d   n o   p r o p e r t i e s ) .f �\ij
�\ 
errni m   C D�[�[�Yj �Zkl
�Z 
erobk o   E F�Y�Y 0 expectederror expectedErrorl �Xm�W
�X 
errtm m   G H�V
�V 
reco�W  �b  �a  ^ non r   R [pqp b   R Yrsr o   R S�U�U 0 expectederror expectedErrors o   S X�T�T *0 _defaulterrorrecord _defaultErrorRecordq o      �S�S 0 expectederror expectedErroro tut Z  \ zvw�R�Qv >   \ gxyx n  \ _z{z 1   ] _�P
�P 
leng{ o   \ ]�O�O 0 expectederror expectedErrory n  _ f|}| 1   d f�N
�N 
leng} o   _ d�M�M *0 _defaulterrorrecord _defaultErrorRecordw R   j v�L~
�L .ascrerr ****      � ****~ m   r u�� ��� � I n v a l i d    i s    p a r a m e t e r   ( r e c o r d   c o n t a i n e d   u n r e c o g n i z e d   p r o p e r t i e s ) . �K��
�K 
errn� m   l m�J�J�Y� �I��
�I 
erob� o   n o�H�H 0 expectederror expectedError� �G��F
�G 
errt� m   p q�E
�E 
reco�F  �R  �Q  u ��� l  { {�D���D  � � � TO DO: what about checking expectedError record's properties are valid types (e.g. error number should be integer, message should be text, etc.), and abort with broken test if not   � ���h   T O   D O :   w h a t   a b o u t   c h e c k i n g   e x p e c t e d E r r o r   r e c o r d ' s   p r o p e r t i e s   a r e   v a l i d   t y p e s   ( e . g .   e r r o r   n u m b e r   s h o u l d   b e   i n t e g e r ,   m e s s a g e   s h o u l d   b e   t e x t ,   e t c . ) ,   a n d   a b o r t   w i t h   b r o k e n   t e s t   i f   n o t� ��� r   { ���� n  { ���� I   � ��C��B�C "0 astextparameter asTextParameter� ��� o   � ��A�A 0 summarytext summaryText� ��@� m   � ��� ���  s u m m a r y�@  �B  � o   { ��?�? 0 _supportlib _supportLib� o      �>�> 0 summarytext summaryText� ��� l  � ��=���=  � G A code-generate a script object to invoke the `call_NAME` handler�   � ��� �   c o d e - g e n e r a t e   a   s c r i p t   o b j e c t   t o   i n v o k e   t h e   ` c a l l _ N A M E `   h a n d l e r &� ��� P   � ���<�� Z   � �����;� =  � ���� o   � ��:�: "0 callhandlername callHandlerName� m   � ��� ���  � l  � ����� r   � ���� b   � ���� m   � ��� ���  c a l l� l  � ���9�8� n   � ���� 7  � ��7��
�7 
ctxt� m   � ��6�6 � m   � ��5�5��� o   � ��4�4 $0 _testhandlername _testHandlerName�9  �8  � o      �3�3 "0 callhandlername callHandlerName� | v if `for` parameter is omitted, automatically call a `call_NAME` handler with the same NAME as the `test_NAME` handler   � ��� �   i f   ` f o r `   p a r a m e t e r   i s   o m i t t e d ,   a u t o m a t i c a l l y   c a l l   a   ` c a l l _ N A M E `   h a n d l e r   w i t h   t h e   s a m e   N A M E   a s   t h e   ` t e s t _ N A M E `   h a n d l e r� ��� H   � ��� C   � ���� o   � ��2�2 "0 callhandlername callHandlerName� m   � ��� ��� 
 c a l l _� ��1� r   � ���� b   � ���� m   � ��� ��� 
 c a l l _� o   � ��0�0 "0 callhandlername callHandlerName� o      �/�/ "0 callhandlername callHandlerName�1  �;  �<  � �.�-
�. conscase�-  � ��� Z   � ����,�� =  � ���� o   � ��+�+  0 parametervalue parameterValue� m   � ��*
�* 
���!� r   � ���� I   � ��)��(�) "0 _makecallobject _makeCallObject� ��� o   � ��'�' "0 callhandlername callHandlerName� ��&� m   � ��%�%  �&  �(  � o      �$�$ 0 
callobject 
callObject�,  � r   � ���� I   � ��#��"�# "0 _makecallobject _makeCallObject� ��� o   � ��!�! "0 callhandlername callHandlerName� �� � m   � ��� �   �"  � o      �� 0 
callobject 
callObject� ��� l  � �����  �   �then call it   � ���    & t h e n   c a l l   i t� ��� Q   ������ k   ��� ��� r   � ���� o   � ��� 0 _novalue _NoValue� o      �� 0 actualerror actualError� ��� l  ����� r   ���� n  � ��� I   � ���� 0 dotest doTest� ��� o   � ��� $0 _testsuiteobject _testSuiteObject� ��� o   � ���  0 parametervalue parameterValue�  �  � o   � ��� 0 
callobject 
callObject� o      �� 0 actualresult actualResult� n h note: this may return literal 'no value' due to AS's schlonky design - this will be accounted for below   � ��� �   n o t e :   t h i s   m a y   r e t u r n   l i t e r a l   ' n o   v a l u e '   d u e   t o   A S ' s   s c h l o n k y   d e s i g n   -   t h i s   w i l l   b e   a c c o u n t e d   f o r   b e l o w�  � R      ���
� .ascrerr ****      � ****� o      �� 0 etext eText� ���
� 
errn� o      �� 0 enumber eNumber� ���
� 
erob� o      �� 0 efrom eFrom� ���
� 
errt� o      �
�
 
0 eto eTo� �	��
�	 
ptlr� o      �� 0 epartial ePartial�  � k  
��� ��� r  
� � m  
�
� boovtrue  o      �� 0 isequal isEqual�  Z 1�� F  ! o  �� 0 isequal isEqual >  n 	
	 o  �� 0 	errortext 	errorText
 o  � �  0 expectederror expectedError o  ���� 0 _novalue _NoValue r  $- = $+ n $) o  %)���� 0 	errortext 	errorText o  $%���� 0 expectederror expectedError o  )*���� 0 etext eText o      ���� 0 isequal isEqual�  �    Z 2U���� F  2E o  23���� 0 isequal isEqual > 6A n 6; o  7;���� 0 errornumber errorNumber o  67���� 0 expectederror expectedError o  ;@���� 0 _novalue _NoValue r  HQ = HO n HM  o  IM���� 0 errornumber errorNumber  o  HI���� 0 expectederror expectedError o  MN���� 0 enumber eNumber o      ���� 0 isequal isEqual��  ��   !"! Z Vy#$����# F  Vi%&% o  VW���� 0 isequal isEqual& > Ze'(' n Z_)*) o  [_���� 0 
errorvalue 
errorValue* o  Z[���� 0 expectederror expectedError( o  _d���� 0 _novalue _NoValue$ r  lu+,+ = ls-.- n lq/0/ o  mq���� 0 
errorvalue 
errorValue0 o  lm���� 0 expectederror expectedError. o  qr���� 0 efrom eFrom, o      ���� 0 isequal isEqual��  ��  " 121 Z z�34����3 F  z�565 o  z{���� 0 isequal isEqual6 > ~�787 n ~�9:9 o  ����� 0 expectedtype expectedType: o  ~���� 0 expectederror expectedError8 o  ������ 0 _novalue _NoValue4 r  ��;<; = ��=>= n ��?@? o  ������ 0 expectedtype expectedType@ o  ������ 0 expectederror expectedError> o  ������ 
0 eto eTo< o      ���� 0 isequal isEqual��  ��  2 ABA Z ��CD����C F  ��EFE o  ������ 0 isequal isEqualF > ��GHG n ��IJI o  ������ 0 partialresult partialResultJ o  ������ 0 expectederror expectedErrorH o  ������ 0 _novalue _NoValueD r  ��KLK = ��MNM n ��OPO o  ������ 0 partialresult partialResultP o  ������ 0 expectederror expectedErrorN o  ������ 0 epartial ePartialL o      ���� 0 isequal isEqual��  ��  B QRQ l ����ST��  S � � TO DO: what about checking error record's properties are valid types (e.g. error number should be integer, message should be text, etc.), and fail test if not   T �UU>   T O   D O :   w h a t   a b o u t   c h e c k i n g   e r r o r   r e c o r d ' s   p r o p e r t i e s   a r e   v a l i d   t y p e s   ( e . g .   e r r o r   n u m b e r   s h o u l d   b e   i n t e g e r ,   m e s s a g e   s h o u l d   b e   t e x t ,   e t c . ) ,   a n d   f a i l   t e s t   i f   n o tR VWV Z ��XY����X o  ������ 0 isequal isEqualY L  ��ZZ I  ����[���� :0 _returnasserterrorsucceeded _returnAssertErrorSucceeded[ \]\ o  ������ 0 summarytext summaryText] ^��^ o  ������ 0 expectederror expectedError��  ��  ��  ��  W _`_ r  ��aba K  ��cc ��de
�� 
pclsd o  ������ $0 _caughterrorinfo _caughtErrorInfoe ��fg�� 0 	errortext 	errorTextf o  ������ 0 etext eTextg ��hi�� 0 errornumber errorNumberh o  ������ 0 enumber eNumberi ��jk�� 0 
errorvalue 
errorValuej o  ������ 0 efrom eFromk ��lm�� 0 expectedtype expectedTypel o  ������ 
0 eto eTom ��n���� 0 partialresult partialResultn o  ������ 0 epartial ePartial��  b o      ���� 0 actualerror actualError` o��o r  ��pqp o  ������ 0 _novalue _NoValueq o      ���� 0 actualresult actualResult��  �  = R      ��rs
�� .ascrerr ****      � ****r o      ���� 0 etext eTexts ��tu
�� 
errnt o      ���� 0 enumber eNumberu ��vw
�� 
erobv o      ���� 0 efrom eFromw ��xy
�� 
errtx o      ���� 
0 eto eToy ��z��
�� 
ptlrz o      ���� 0 epartial ePartial��  > I  ��{���� .0 _raisedefectiveassert _raiseDefectiveAssert{ |}| o  ���� 0 summarytext summaryText} ~~ b  ��� m  
�� ��� 6 C a n  t    a s s e r t   t e s t   e r r o r  :  � o  
���� 0 etext eText ��� o  ���� 0 enumber eNumber� ��� o  ���� 0 efrom eFrom� ��� o  ���� 
0 eto eTo� ���� o  ���� 0 epartial ePartial��  ��  ; ��� Q  *���� l ���� l ���� r  ��� o  ���� 0 actualresult actualResult� o      ���� 0 actualresult actualResult� � z this variable lookup fails if call_NAME returned nothing (i.e. `null`, which AS literally treats as 'no value at all')...   � ��� �   t h i s   v a r i a b l e   l o o k u p   f a i l s   i f   c a l l _ N A M E   r e t u r n e d   n o t h i n g   ( i . e .   ` n u l l ` ,   w h i c h   A S   l i t e r a l l y   t r e a t s   a s   ' n o   v a l u e   a t   a l l ' ) . . .� g a kludge-around for AS's dumb commands-are-not-expressions-so-do-not-have-to-return-results design   � ��� �   k l u d g e - a r o u n d   f o r   A S ' s   d u m b   c o m m a n d s - a r e - n o t - e x p r e s s i o n s - s o - d o - n o t - h a v e - t o - r e t u r n - r e s u l t s   d e s i g n� R      �����
�� .ascrerr ****      � ****��  � �����
�� 
errn� d      �� m      ����
���  � l #*���� r  #*��� o  #(���� 0 _novalue _NoValue� o      ���� 0 actualresult actualResult� a [ ... in which case replace it with a 'no value placeholder' object that AS can actually see   � ��� �   . . .   i n   w h i c h   c a s e   r e p l a c e   i t   w i t h   a   ' n o   v a l u e   p l a c e h o l d e r '   o b j e c t   t h a t   A S   c a n   a c t u a l l y   s e e� ���� I  +6������� 20 _raiseasserterrorfailed _raiseAssertErrorFailed� ��� o  ,-���� 0 summarytext summaryText� ��� o  -.���� 0 expectederror expectedError� ��� o  ./���� 0 actualerror actualError� ���� o  /0���� 0 actualresult actualResult��  ��  ��  7 ���
�� conscase� ���
�� consdiac� ���
�� conshyph� ���
�� conspunc� ����
�� conswhit��  8 ����
�� consnume��  �p   ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ���� l     ��������  ��  ��  ��        ��������������~��}�|x}������{����������  � �z�y�x�w�v�u�t�s�r�q�p�o�n�m�l�k�j�i�h�g�f�e�d�c�b�a�`�_�^�]�z 0 _supportlib _supportLib
�y 
pimr�x 0 istype isType�w 0 
randomword 
randomWord
�v .���:MTmrnull��� ��� ctxt�u 40 _defectiveassertionerror _DefectiveAssertionError�t 00 _abortedassertionerror _AbortedAssertionError�s 0 _isequaldelta _isEqualDelta�r 0 _novalue _NoValue�q 00 _abortedassertiontoken _AbortedAssertionToken�p $0 _caughterrorinfo _caughtErrorInfo�o *0 _defaulterrorrecord _defaultErrorRecord�n $0 _testsuiteobject _testSuiteObject�m 0 _testreport _testReport�l 0 _success _SUCCESS�k 0 _failure _FAILURE�j 0 _broken _BROKEN�i 0 vt100 VT100�h "0 _maketestreport _makeTestReport�g (0 sanitizeidentifier sanitizeIdentifier�f "0 _makecallobject _makeCallObject�e $0 _testhandlername _testHandlerName�d 0 __performunittestforsuite__  �c <0 _returnassertresultsucceeded _returnAssertResultSucceeded�b 40 _raiseassertresultfailed _raiseAssertResultFailed�a :0 _returnasserterrorsucceeded _returnAssertErrorSucceeded�` 20 _raiseasserterrorfailed _raiseAssertErrorFailed�_ .0 _raisedefectiveassert _raiseDefectiveAssert
�^ .���:AsRenull��� ��� null
�] .���:AsErnull��� ��� null� ��   �\ 
�\ 
scpt� �[��[ �  ��� �Z��Y
�Z 
cobj� ��   �X 
�X 
frmk�Y  � �W��V
�W 
cobj� ��   �U
�U 
osax�V  � �T 3�S�R���Q�T 0 istype isType�S �P��P �  �O�N�O 0 thevalue theValue�N 0 typename typeName�R  � �M�L�M 0 thevalue theValue�L 0 typename typeName� �K�J
�K 
kocl
�J .corecnte****       ****�Q �kv�l j� �I F�H�G���F�I 0 
randomword 
randomWord�H �E��E �  �D�C�D 0 	minlength 	minLength�C 0 	maxlength 	maxLength�G  � �B�A�@�B 0 	minlength 	minLength�A 0 	maxlength 	maxLength�@ 0 s  �  S�?�>�=�<�; _�:
�? misccura
�> 
from
�= 
to  �< 
�; .sysorandnmbr    ��� nmbr
�: 
cobj�F (�E�O � *��� Ukh���.%E�[OY��O�� �9 {�8�7���6
�9 .���:MTmrnull��� ��� ctxt�8 {�5�4 ��5 0 nametext nameText�4  �7  � �3�2�3 0 nametext nameText�2 0 timerobject TimerObject� �1 ���1 0 timerobject TimerObject� �0��/�.���-
�0 .ascrinit****      � ****� k     '��  ���  ���  ���  ���  ���  ���  ���  ���  ��,�,  �/  �.  � 	�+�*�)�(�'�&�%�$�#
�+ 
pimr�* 0 
_starttime 
_startTime�) 0 _totalseconds _totalSeconds�( 0 
_isrunning 
_isRunning�' 0 	timername 	timerName�& 0 
starttimer 
startTimer�% 0 	stoptimer 	stopTimer�$ 0 elapsedtime elapsedTime�# 0 	totaltime 	totalTime� �"�! �� � ��������
�" 
cobj
�! 
frmk
�  
msng� 0 
_starttime 
_startTime� 0 _totalseconds _totalSeconds� 0 
_isrunning 
_isRunning� � ������� 0 	timername 	timerName�  �  �  �  � b   � � ������� 0 
starttimer 
startTimer�  �  �  � ���
� misccura� 0 nsdate NSDate� @0 timeintervalsincereferencedate timeIntervalSinceReferenceDate� (b   hY hOeEc  O��,j+ Ec  O)� � ������� 0 	stoptimer 	stopTimer�  �  � �� 0 elapsedtime elapsedTime� ���

� misccura� 0 nsdate NSDate�
 @0 timeintervalsincereferencedate timeIntervalSinceReferenceDate� 9b   jY hO��,j+ b  E�Ob  �Ec  OfEc  O�� �	 �������	 0 elapsedtime elapsedTime�  �  � �� 0 nsdate NSDate� �� @0 timeintervalsincereferencedate timeIntervalSinceReferenceDate� b   �j+  b  Y j� � ������ � 0 	totaltime 	totalTime�  �  �  � ���� 0 elapsedtime elapsedTime�  b   b  *j+  Y b  �- (�*��/lkv��O�Of�OL OL 	OL 
OL OL �6 ��K S���@�A� ��%  ��� 0 _novalue _NoValue�  ��  � ��-  ��� 00 _abortedassertiontoken _AbortedAssertionToken�  ��  
�~ 
����� �����
�� 
pcls
�� 
����� ������ 0 	errortext 	errorText� ������ 0 errornumber errorNumber� ������ 0 
errorvalue 
errorValue� ������ 0 expectedtype expectedType� ������� 0 partialresult partialResult��  
�} 
msng
�| 
msng� ��������	 ���� 0 vt100 VT100�� ��	�� 	  ���� 0 
formatcode 
formatCode��  � ���� 0 
formatcode 
formatCode	  ��������
�� 
cha �� 
�� kfrmID  �� )���0�%�%�%� �������		���� "0 _maketestreport _makeTestReport�� ��	�� 	  �������� 0 testsuitename testSuiteName�� "0 testhandlername testHandlerName�� 0 isstyled isStyled��  	 ������������ 0 testsuitename testSuiteName�� "0 testhandlername testHandlerName�� 0 isstyled isStyled�� 0 vtstyle vtStyle�� 0 
testreport 
TestReport	 ���������������������������������	�� 0 n  �� 0 vt100 VT100�� 0 b  �� 0 u  �� �� 0 r  �� �� 0 g  ��  �� 0 e  �� "�� �� 0 
testreport 
TestReport	 ��	����		��
�� .ascrinit****      � ****	 k     				 �	
	
 �		  		 		 M		 R		 		 d����  ��  ��  	 ������������������ 0 _testresults _testResults�� 0 
_dataindex 
_dataIndex�� 0 _datasubindex _dataSubIndex�� 0 	addreport 	addReport�� $0 _errorrecordrefs _errorRecordRefs�� 0 nextrawdata  �� 0 updaterawdata  �� 0 renderreport  	 ������	��			�� 0 _testresults _testResults�� 0 
_dataindex 
_dataIndex�� 0 _datasubindex _dataSubIndex	 ������		���� 0 	addreport 	addReport�� ��	�� 	  �������� 0 outcometype outcomeType�� 0 summarytext summaryText�� 0 testdata testData��  	 �������� 0 outcometype outcomeType�� 0 summarytext summaryText�� 0 testdata testData	 ���������� 0 outcometype outcomeType�� 0 summarytext summaryText�� 0 testdata testData�� �� ����b   6FOP�� $0 _errorrecordrefs _errorRecordRefs	 ��U����		���� 0 nextrawdata  ��  ��  	 �������� 0 	erroritem 	errorItem�� 0 datalist dataList�� 0 thedata theData	 ��������������������������������������
�� 
leng
�� 
cobj
�� 
pcnt
�� 
rest�� 0 nextrawdata  �� 0 testdata testData
�� 
reco�� 0 istype isType
�� 
pcls
�� 
bool�� 0 errornumber errorNumber�� 0 
errorvalue 
errorValue�� 0 expectedtype expectedType�� 0 partialresult partialResult�� �� 0 	errortext 	errorText
�� 
ctxt
�� 
errn��f��2b  b   �,b  jv Tb  �k/�,E�O�b    6b  �,Ec  Ob  jv  b  kEc  Y hO*j+ Y hO�Y hOb   �b  /�,E�Ob  ��, p��b  /�l/E�O*��l+ 	 ��,b  
 �& C��,��,��,��,�vEc  O*��,a l+  ��,b  6FY hO*j+ Y hO�Y *b  kklvE[�k/Ec  Z[�l/Ec  ZO*j+ Y hO)a a lh	 ������		���� 0 updaterawdata  �� ��	�� 	  ���� 0 literaltext literalText��  	 ���� 0 literaltext literalText	 ��������
�� 
cobj�� 0 testdata testData
�� 
pcnt
�� 
rest�� qb  jv  -�b   �b  /�,�b  /�l/FOb  kEc  Y 9�b  �k/�,FOb  �,Ec  Ob  jv  b  kEc  Y hOh	 ��g����		���� 0 renderreport  ��  ��  	  	 o�� ��� jv�Ok�Ok�OL Ojv�OL OL OL �� V� 3�*jk+ �*kk+ �*�k+ �*�k+ �*�k+ �*�k+ �E�Y ���������a �a �E�Oa a K S�� �������		 ���� (0 sanitizeidentifier sanitizeIdentifier�� ��	!�� 	!  ���� 0 aname aName��  	 ������~�}�� 0 aname aName�� 0 res  � 0 
legalchars 
legalChars�~ 0 usepipes usePipes�} 0 charref charRef	  �������|�{�z�y�����
�| 
kocl
�{ 
cobj
�z .corecnte****       ****
�y 
pcnt�� t�� p��  �Y hO�E�O�E�OfE�O @�[��l kh ���, eE�O��, 
�%E�Y hY hO��%E�O�E�[OY��O� ��%�%E�Y hO�V� �x��w�v	"	#�u�x "0 _makecallobject _makeCallObject�w �t	$�t 	$  �s�r�s 0 handlername handlerName�r  0 parametercount parameterCount�v  	" �q�p�o�n�q 0 handlername handlerName�p  0 parametercount parameterCount�o 0 args  �n 0 i  	# �m-3�l59;�k
�m 
ctxt�l (0 sanitizeidentifier sanitizeIdentifier
�k .sysodsct****        scpt�u T�j -�E�O k�kh ��%�%E�[OY��O�[�\[Zm\Zi2E�Y �E�O�*�%k+ %�%*�k+ %�%�%�%j 

�{ 
msng� �jS�i�h	%	&�g�j 0 __performunittestforsuite__  �i �f	'�f 	'  �e	(�e 0 suiteobject suiteObject	( �d	)�d 	)  �c�b�a�`�c 0 	suitename 	suiteName�b 0 handlername handlerName�a 0 handlerkeys handlerKeys�` 0 isstyled isStyled�h  	% �_�^�]�\�[�Z�Y�X�W�V�U�T�_ 0 suiteobject suiteObject�^ 0 	suitename 	suiteName�] 0 handlername handlerName�\ 0 handlerkeys handlerKeys�[ 0 isstyled isStyled�Z 0 etext eText�Y 0 enumber eNumber�X 0 efrom eFrom�W 
0 eto eTo�V 0 epartial ePartial�U 0 summarytext summaryText�T 0 
callobject 
callObject	& �S��R�Q	*��P�O�N�M�L�K�J�I�H�G�F�E��D4�S "0 _maketestreport _makeTestReport�R 0 setup setUp�Q 0 etext eText	* �C�B	+
�C 
errn�B 0 enumber eNumber	+ �A�@	,
�A 
erob�@ 0 efrom eFrom	, �?�>	-
�? 
errt�> 
0 eto eTo	- �=�<�;
�= 
ptlr�< 0 epartial ePartial�;  
�P 
pcls�O 0 	errortext 	errorText�N 0 errornumber errorNumber�M 0 
errorvalue 
errorValue�L 0 expectedtype expectedType�K 0 partialresult partialResult�J �I 0 	addreport 	addReport
�H 
msng�G "0 _makecallobject _makeCallObject�F 0 dotest doTest
�E 
bool�D 0 teardown tearDown�g)�Ec  O�Ec  O*���m+  Ec  O ��kv 
�j+ Y hW <X  b  b  ���b  
������lvkvm+ O�Ec  Ob  O*�jl+ E�O ���l+ W LX  �b   	 �b  	 a & -b  b  �a �b  
������lvkvm+ Y hO �a kv 
�j+ Y hW /X  b  b  �a �b  
������lvkvm+ O�Ec  Ob  � �:`�9�8	.	/�7�: <0 _returnassertresultsucceeded _returnAssertResultSucceeded�9 �6	0�6 	0  �5�4�5 0 summarytext summaryText�4  0 expectedresult expectedResult�8  	. �3�2�3 0 summarytext summaryText�2  0 expectedresult expectedResult	/ x�1�1 0 	addreport 	addReport�7 b  b  ��lvkvm+ Oh� �0��/�.	1	2�-�0 40 _raiseassertresultfailed _raiseAssertResultFailed�/ �,	3�, 	3  �+�*�)�+ 0 summarytext summaryText�*  0 expectedresult expectedResult�) 0 actualresult actualResult�.  	1 �(�'�&�( 0 summarytext summaryText�'  0 expectedresult expectedResult�& 0 actualresult actualResult	2 ���%�$�#�"�% 0 	addreport 	addReport
�$ 
errn
�# 
erob�" �- +b  b  ��lv�lvlvm+ O)�b  �b  	�h� �!�� �	4	5��! :0 _returnasserterrorsucceeded _returnAssertErrorSucceeded�  �	6� 	6  ��� 0 summarytext summaryText� 0 expectederror expectedError�  	4 ��� 0 summarytext summaryText� 0 expectederror expectedError	5 ��� 0 	addreport 	addReport� b  b  ��lvkvm+ Oh� ����	7	8�� 20 _raiseasserterrorfailed _raiseAssertErrorFailed� �	9� 	9  ����� 0 summarytext summaryText� 0 expectederror expectedError� 0 actualerror actualError� 0 actualresult actualResult�  	7 �����
� 0 summarytext summaryText� 0 expectederror expectedError� 0 actualerror actualError� 0 actualresult actualResult�
 0 testdata testData	8 ���	����	 0 	addreport 	addReport
� 
errn
� 
erob� � W�lvkvE�O�b   �lv�6FY hO�b   �lv�6FY hOb  b  ��m+ O)�b  �b  	�h� �"��	:	;�� .0 _raisedefectiveassert _raiseDefectiveAssert� �	<� 	<  � �����������  0 summarytext summaryText�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo�� 0 epartial ePartial�  	: �������������� 0 summarytext summaryText�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo�� 0 epartial ePartial	; ?����������������������
�� 
pcls�� 0 	errortext 	errorText�� 0 errornumber errorNumber�� 0 
errorvalue 
errorValue�� 0 expectedtype expectedType�� 0 partialresult partialResult�� �� 0 	addreport 	addReport
�� 
errn
�� 
erob�� � 8b  b  ���b  
������lvkvm+ O)�b  �b  	�h� ��o����	=	>��
�� .���:AsRenull��� ��� null��  �� ����	?
�� 
Valu�� 0 actualresult actualResult	? ����	@
�� 
Equa��  0 expectedresult expectedResult	@ ��	A	B
�� 
Summ	A {����z�� 0 summarytext summaryText��  	B ��	C��
�� 
FCmp	C {�������� $0 hasrealtolerance hasRealTolerance��  
�� boovfals��  	= 
���������������������� 0 actualresult actualResult��  0 expectedresult expectedResult�� 0 summarytext summaryText�� $0 hasrealtolerance hasRealTolerance�� 0 isequal isEqual�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo�� 0 epartial ePartial	> �����������������������������������������	D���
�� 
msng
�� 
errn���T�� "0 astextparameter asTextParameter�� (0 asbooleanparameter asBooleanParameter
�� 
nmbr�� 0 istype isType
�� 
bool���Y
�� 
erob
�� 
errt
�� 
doub�� 
�� 
pcls�� <0 _returnassertresultsucceeded _returnAssertResultSucceeded�� 40 _raiseassertresultfailed _raiseAssertResultFailed�� 0 etext eText	D ����	E
�� 
errn�� 0 enumber eNumber	E ����	F
�� 
erob�� 0 efrom eFrom	F ����	G
�� 
errt�� 
0 eto eTo	G ������
�� 
ptlr�� 0 epartial ePartial��  �� .0 _raisedefectiveassert _raiseDefectiveAssert�� �b  �  )��l�Y hO�� � �b   ��l+ E�Ob   ��l+ 	E�O�	 *��l+ �& )����a a a �a ,%a %Y hO� �b  �	 �b  ��&E�Y �� E�O� *��l+ Y hO*���m+ W X  *�a �%����a + V� ������	H	I��
�� .���:AsErnull��� ��� null��  �� ��	J	K
�� 
Hand	J {������ "0 callhandlername callHandlerName��  	K ��	L	M
�� 
Args	L {��������  0 parametervalue parameterValue��  
�� 
���!	M ����	N
�� 
Equa�� 0 expectederror expectedError	N ��	O��
�� 
Summ	O {����'�� 0 summarytext summaryText��  ��  	H ���������������������������� "0 callhandlername callHandlerName��  0 parametervalue parameterValue�� 0 expectederror expectedError�� 0 summarytext summaryText�� 0 
callobject 
callObject�� 0 actualerror actualError�� 0 actualresult actualResult�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo�� 0 epartial ePartial�� 0 isequal isEqual	I .������278J��V��������������g�������������������	P��������������~�}��|�{	Q�z�y
�� 
msng
�� 
errn���T�� "0 astextparameter asTextParameter�� &0 asrecordparameter asRecordParameter
�� 
leng���Y
�� 
erob
�� 
errt
�� 
reco�� 
�� 
ctxt�� 
�� 
���!�� "0 _makecallobject _makeCallObject�� 0 dotest doTest�� 0 etext eText	P �x�w	R
�x 
errn�w 0 enumber eNumber	R �v�u	S
�v 
erob�u 0 efrom eFrom	S �t�s	T
�t 
errt�s 
0 eto eTo	T �r�q�p
�r 
ptlr�q 0 epartial ePartial�p  �� 0 	errortext 	errorText
�� 
bool�� 0 errornumber errorNumber�� 0 
errorvalue 
errorValue�� 0 expectedtype expectedType�� 0 partialresult partialResult� :0 _returnasserterrorsucceeded _returnAssertErrorSucceeded
�~ 
pcls�} �| .0 _raisedefectiveassert _raiseDefectiveAssert�{  	Q �o�n�m
�o 
errn�n�?�m  �z �y 20 _raiseasserterrorfailed _raiseAssertErrorFailed��8b  �  )��l�Y hO���b   ��l+ E�Ob   ��l+ 	E�O��,j  )������a Y hO�b  %E�O��,b  �, )������a Y hOb   �a l+ E�Oga  ;�a   a b  [a \[Za \Zi2%E�Y �a  a �%E�Y hVO�a   *�jl+ E�Y *�kl+ E�O b  E�O�b  �l+ E�W �X  eE�O�	 �a ,b  a  & �a ,� E�Y hO�	 �a !,b  a  & �a !,� E�Y hO�	 �a ",b  a  & �a ",� E�Y hO�	 �a #,b  a  & �a #,� E�Y hO�	 �a $,b  a  & �a $,� E�Y hO� *��l+ %Y hOa &b  
a �a !�a "�a #�a $�a 'E�Ob  E�W X  *�a (�%�����+ )O �E�W X * +b  E�O*����a ,+ -V ascr  ��ޭ