FasdUAS 1.101.10   ��   ��    k             l      ��  ��   �� TestLib -- unit testing framework and other testing/profiling tools

About:

- TestLib's unit testing framework takes a NAME.unittest.scpt file containing one or more script objects, each representing a test suite, and each of those script objects containing one or more handlers representing individual unit tests. Test suite scripts must have `suite_` name prefixes; test handlers within those scripts must have `test_` name prefixes.

- The command line `osatest` test runner introspects the unittest script to obtain all suite and test names. For each found test it creates a new AppleScript component instance (interpreter), loads a clean copy of the unittest script into it, then calls [indirectly] TestLib's `__performunittestforsuite__` handler to run that test. The resulting `TestReport` object is then returned to `osatest` to finish generating the report for that test and print it.

Notes:

- Saving unittest scripts as compiled `.scpt` files rather than `.applescript` snippets avoids any risk of test scripts not compiling correctly when run by `osatest` - i.e. it's one less thing to go wrong.

- The `.unittest.scpt[d]` suffix is a convention, not a requirement, but is strongly encouraged. e.g. Future improvements to `osatest` may include the ability to search a library script bundle for any embedded unittest files and run them all automatically.

- Suite scripts can't inherit `configure_setUp ` and `configure_tearDown ` directly from parent scripts (OSA-based introspection only checks for handler names in the current script;)

TO DO:

- implement line-wrapping in TestSupport.scpt to improve readability when displaying reports in Terminal

- embed `osatest` executable in library bundle? or is it best to keep it separate?

- should all code+terms not immediately related to unit testing be moved to a separate module (or vice-versa, moving UT code to `UnitTestLib`)? (the less risk of keyword/AE code collisions with the code being tested, the better)

- options for automatically spiking TIDs and considering/ignoring options before calling `test_NAME` handler; also, what about an option for composing/decomposing unicode (assuming that's an issue in AS/Cocoa, e.g. when comparing/sorting AS/NS strings); note that localization is harder to spike, but should be done if possible as it affects date and number coercions

- what other assert test options (e.g. `is in`, `is not`, etc)? best solution would be to pass an `assert [is/is not/is in/is not in/is type/is not type/etc] comparator` script object that performs the appropriate test as an additional parameter; that avoids adding lots of optional params for each comparison type (most of which are rarely used), which would bloat the API and be non-extensible; in particular, asserting a script object-based result will most likely require a custom checker (otherwise checking each detail would require a separate assert, since script objects don't compare for logical equivalence, only identify); ditto when result being checked is an ASOC ocid specifier (in which case the other value should be checked to see if it's also an ocid, and if it is then use `(v1's isEqual: v2)`)


- what other check objects should be defined as standard? e.g. `exact range check`, `numeric range check`, `exact containment check`, `exact type check` (checks only that the expected and actual values are of the same type; relatively weak, but still potentially of some use when checking, say, e.g. that actual errorNumber is `integer` and actual errorText is `text`), `ASObjC equality check`(checks both values are ocid specifiers then compares them using `-isEqual:`), `text pattern check` (allow wildcard/regexp checking, possibly applying additional check objects to wildcard-matched ranges; this could be useful e.g. when checking error messages where some parts of the message may vary - e.g. disk and home folder names in file paths - so should be either ignored or custom-checked but the rest of the message is constant); also, how might multiple checks be usefully composed? (e.g. currently the `exact error check` constructor optionally accepts an record of one or more equality checkers for customizing how specific error attributes are checked)

      � 	 	!   T e s t L i b   - -   u n i t   t e s t i n g   f r a m e w o r k   a n d   o t h e r   t e s t i n g / p r o f i l i n g   t o o l s 
 
 A b o u t : 
 
 -   T e s t L i b ' s   u n i t   t e s t i n g   f r a m e w o r k   t a k e s   a   N A M E . u n i t t e s t . s c p t   f i l e   c o n t a i n i n g   o n e   o r   m o r e   s c r i p t   o b j e c t s ,   e a c h   r e p r e s e n t i n g   a   t e s t   s u i t e ,   a n d   e a c h   o f   t h o s e   s c r i p t   o b j e c t s   c o n t a i n i n g   o n e   o r   m o r e   h a n d l e r s   r e p r e s e n t i n g   i n d i v i d u a l   u n i t   t e s t s .   T e s t   s u i t e   s c r i p t s   m u s t   h a v e   ` s u i t e _ `   n a m e   p r e f i x e s ;   t e s t   h a n d l e r s   w i t h i n   t h o s e   s c r i p t s   m u s t   h a v e   ` t e s t _ `   n a m e   p r e f i x e s . 
 
 -   T h e   c o m m a n d   l i n e   ` o s a t e s t `   t e s t   r u n n e r   i n t r o s p e c t s   t h e   u n i t t e s t   s c r i p t   t o   o b t a i n   a l l   s u i t e   a n d   t e s t   n a m e s .   F o r   e a c h   f o u n d   t e s t   i t   c r e a t e s   a   n e w   A p p l e S c r i p t   c o m p o n e n t   i n s t a n c e   ( i n t e r p r e t e r ) ,   l o a d s   a   c l e a n   c o p y   o f   t h e   u n i t t e s t   s c r i p t   i n t o   i t ,   t h e n   c a l l s   [ i n d i r e c t l y ]   T e s t L i b ' s   ` _ _ p e r f o r m u n i t t e s t f o r s u i t e _ _ `   h a n d l e r   t o   r u n   t h a t   t e s t .   T h e   r e s u l t i n g   ` T e s t R e p o r t `   o b j e c t   i s   t h e n   r e t u r n e d   t o   ` o s a t e s t `   t o   f i n i s h   g e n e r a t i n g   t h e   r e p o r t   f o r   t h a t   t e s t   a n d   p r i n t   i t . 
 
 N o t e s : 
 
 -   S a v i n g   u n i t t e s t   s c r i p t s   a s   c o m p i l e d   ` . s c p t `   f i l e s   r a t h e r   t h a n   ` . a p p l e s c r i p t `   s n i p p e t s   a v o i d s   a n y   r i s k   o f   t e s t   s c r i p t s   n o t   c o m p i l i n g   c o r r e c t l y   w h e n   r u n   b y   ` o s a t e s t `   -   i . e .   i t ' s   o n e   l e s s   t h i n g   t o   g o   w r o n g . 
 
 -   T h e   ` . u n i t t e s t . s c p t [ d ] `   s u f f i x   i s   a   c o n v e n t i o n ,   n o t   a   r e q u i r e m e n t ,   b u t   i s   s t r o n g l y   e n c o u r a g e d .   e . g .   F u t u r e   i m p r o v e m e n t s   t o   ` o s a t e s t `   m a y   i n c l u d e   t h e   a b i l i t y   t o   s e a r c h   a   l i b r a r y   s c r i p t   b u n d l e   f o r   a n y   e m b e d d e d   u n i t t e s t   f i l e s   a n d   r u n   t h e m   a l l   a u t o m a t i c a l l y . 
 
 -   S u i t e   s c r i p t s   c a n ' t   i n h e r i t   ` c o n f i g u r e _ s e t U p   `   a n d   ` c o n f i g u r e _ t e a r D o w n   `   d i r e c t l y   f r o m   p a r e n t   s c r i p t s   ( O S A - b a s e d   i n t r o s p e c t i o n   o n l y   c h e c k s   f o r   h a n d l e r   n a m e s   i n   t h e   c u r r e n t   s c r i p t ; ) 
 
 T O   D O : 
 
 -   i m p l e m e n t   l i n e - w r a p p i n g   i n   T e s t S u p p o r t . s c p t   t o   i m p r o v e   r e a d a b i l i t y   w h e n   d i s p l a y i n g   r e p o r t s   i n   T e r m i n a l 
 
 -   e m b e d   ` o s a t e s t `   e x e c u t a b l e   i n   l i b r a r y   b u n d l e ?   o r   i s   i t   b e s t   t o   k e e p   i t   s e p a r a t e ? 
 
 -   s h o u l d   a l l   c o d e + t e r m s   n o t   i m m e d i a t e l y   r e l a t e d   t o   u n i t   t e s t i n g   b e   m o v e d   t o   a   s e p a r a t e   m o d u l e   ( o r   v i c e - v e r s a ,   m o v i n g   U T   c o d e   t o   ` U n i t T e s t L i b ` ) ?   ( t h e   l e s s   r i s k   o f   k e y w o r d / A E   c o d e   c o l l i s i o n s   w i t h   t h e   c o d e   b e i n g   t e s t e d ,   t h e   b e t t e r ) 
 
 -   o p t i o n s   f o r   a u t o m a t i c a l l y   s p i k i n g   T I D s   a n d   c o n s i d e r i n g / i g n o r i n g   o p t i o n s   b e f o r e   c a l l i n g   ` t e s t _ N A M E `   h a n d l e r ;   a l s o ,   w h a t   a b o u t   a n   o p t i o n   f o r   c o m p o s i n g / d e c o m p o s i n g   u n i c o d e   ( a s s u m i n g   t h a t ' s   a n   i s s u e   i n   A S / C o c o a ,   e . g .   w h e n   c o m p a r i n g / s o r t i n g   A S / N S   s t r i n g s ) ;   n o t e   t h a t   l o c a l i z a t i o n   i s   h a r d e r   t o   s p i k e ,   b u t   s h o u l d   b e   d o n e   i f   p o s s i b l e   a s   i t   a f f e c t s   d a t e   a n d   n u m b e r   c o e r c i o n s 
 
 -   w h a t   o t h e r   a s s e r t   t e s t   o p t i o n s   ( e . g .   ` i s   i n ` ,   ` i s   n o t ` ,   e t c ) ?   b e s t   s o l u t i o n   w o u l d   b e   t o   p a s s   a n   ` a s s e r t   [ i s / i s   n o t / i s   i n / i s   n o t   i n / i s   t y p e / i s   n o t   t y p e / e t c ]   c o m p a r a t o r `   s c r i p t   o b j e c t   t h a t   p e r f o r m s   t h e   a p p r o p r i a t e   t e s t   a s   a n   a d d i t i o n a l   p a r a m e t e r ;   t h a t   a v o i d s   a d d i n g   l o t s   o f   o p t i o n a l   p a r a m s   f o r   e a c h   c o m p a r i s o n   t y p e   ( m o s t   o f   w h i c h   a r e   r a r e l y   u s e d ) ,   w h i c h   w o u l d   b l o a t   t h e   A P I   a n d   b e   n o n - e x t e n s i b l e ;   i n   p a r t i c u l a r ,   a s s e r t i n g   a   s c r i p t   o b j e c t - b a s e d   r e s u l t   w i l l   m o s t   l i k e l y   r e q u i r e   a   c u s t o m   c h e c k e r   ( o t h e r w i s e   c h e c k i n g   e a c h   d e t a i l   w o u l d   r e q u i r e   a   s e p a r a t e   a s s e r t ,   s i n c e   s c r i p t   o b j e c t s   d o n ' t   c o m p a r e   f o r   l o g i c a l   e q u i v a l e n c e ,   o n l y   i d e n t i f y ) ;   d i t t o   w h e n   r e s u l t   b e i n g   c h e c k e d   i s   a n   A S O C   o c i d   s p e c i f i e r   ( i n   w h i c h   c a s e   t h e   o t h e r   v a l u e   s h o u l d   b e   c h e c k e d   t o   s e e   i f   i t ' s   a l s o   a n   o c i d ,   a n d   i f   i t   i s   t h e n   u s e   ` ( v 1 ' s   i s E q u a l :   v 2 ) ` ) 
 
 
 -   w h a t   o t h e r   c h e c k   o b j e c t s   s h o u l d   b e   d e f i n e d   a s   s t a n d a r d ?   e . g .   ` e x a c t   r a n g e   c h e c k ` ,   ` n u m e r i c   r a n g e   c h e c k ` ,   ` e x a c t   c o n t a i n m e n t   c h e c k ` ,   ` e x a c t   t y p e   c h e c k `   ( c h e c k s   o n l y   t h a t   t h e   e x p e c t e d   a n d   a c t u a l   v a l u e s   a r e   o f   t h e   s a m e   t y p e ;   r e l a t i v e l y   w e a k ,   b u t   s t i l l   p o t e n t i a l l y   o f   s o m e   u s e   w h e n   c h e c k i n g ,   s a y ,   e . g .   t h a t   a c t u a l   e r r o r N u m b e r   i s   ` i n t e g e r `   a n d   a c t u a l   e r r o r T e x t   i s   ` t e x t ` ) ,   ` A S O b j C   e q u a l i t y   c h e c k ` ( c h e c k s   b o t h   v a l u e s   a r e   o c i d   s p e c i f i e r s   t h e n   c o m p a r e s   t h e m   u s i n g   ` - i s E q u a l : ` ) ,   ` t e x t   p a t t e r n   c h e c k `   ( a l l o w   w i l d c a r d / r e g e x p   c h e c k i n g ,   p o s s i b l y   a p p l y i n g   a d d i t i o n a l   c h e c k   o b j e c t s   t o   w i l d c a r d - m a t c h e d   r a n g e s ;   t h i s   c o u l d   b e   u s e f u l   e . g .   w h e n   c h e c k i n g   e r r o r   m e s s a g e s   w h e r e   s o m e   p a r t s   o f   t h e   m e s s a g e   m a y   v a r y   -   e . g .   d i s k   a n d   h o m e   f o l d e r   n a m e s   i n   f i l e   p a t h s   -   s o   s h o u l d   b e   e i t h e r   i g n o r e d   o r   c u s t o m - c h e c k e d   b u t   t h e   r e s t   o f   t h e   m e s s a g e   i s   c o n s t a n t ) ;   a l s o ,   h o w   m i g h t   m u l t i p l e   c h e c k s   b e   u s e f u l l y   c o m p o s e d ?   ( e . g .   c u r r e n t l y   t h e   ` e x a c t   e r r o r   c h e c k `   c o n s t r u c t o r   o p t i o n a l l y   a c c e p t s   a n   r e c o r d   o f   o n e   o r   m o r e   e q u a l i t y   c h e c k e r s   f o r   c u s t o m i z i n g   h o w   s p e c i f i c   e r r o r   a t t r i b u t e s   a r e   c h e c k e d ) 
 
     
  
 l     ��������  ��  ��        x     �� ����    4    �� 
�� 
frmk  m       �    F o u n d a t i o n��        l     ��������  ��  ��        x    �� ����    2   ��
�� 
osax��        l     ��������  ��  ��        l     ��  ��    J D--------------------------------------------------------------------     �   � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -      l     ��   !��       support    ! � " "    s u p p o r t   # $ # l     ��������  ��  ��   $  % & % l      ' ( ) ' j    �� *�� 0 _supportlib _supportLib * N     + + 4    �� ,
�� 
scpt , m     - - � . . " L i b r a r y S u p p o r t L i b ( "  used for parameter checking    ) � / / 8   u s e d   f o r   p a r a m e t e r   c h e c k i n g &  0 1 0 l     ��������  ��  ��   1  2 3 2 i   ! 4 5 4 I      �� 6���� 
0 _error   6  7 8 7 o      ���� 0 handlername handlerName 8  9 : 9 o      ���� 0 etext eText :  ; < ; o      ���� 0 enumber eNumber <  = > = o      ���� 0 efrom eFrom >  ?�� ? o      ���� 
0 eto eTo��  ��   5 n     @ A @ I    �� B���� &0 throwcommanderror throwCommandError B  C D C m     E E � F F  T e s t L i b D  G H G o    ���� 0 handlername handlerName H  I J I o    ���� 0 etext eText J  K L K o    	���� 0 enumber eNumber L  M N M o   	 
���� 0 efrom eFrom N  O�� O o   
 ���� 
0 eto eTo��  ��   A o     ���� 0 _supportlib _supportLib 3  P Q P l     ��������  ��  ��   Q  R S R l     ��������  ��  ��   S  T U T l      V W X V j   " (�� Y�� 0 _testsupport _TestSupport Y N   " ' Z Z 4   " &�� [
�� 
scpt [ m   $ % \ \ � ] ]  T e s t S u p p o r t W , & sub-library embedded in TestLib.scptd    X � ^ ^ L   s u b - l i b r a r y   e m b e d d e d   i n   T e s t L i b . s c p t d U  _ ` _ l     ��������  ��  ��   `  a b a l     ��������  ��  ��   b  c d c l     �� e f��   e J D--------------------------------------------------------------------    f � g g � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - d  h i h l     �� j k��   j   Test Utilities    k � l l    T e s t   U t i l i t i e s i  m n m l     ��������  ��  ��   n  o p o i  ) , q r q I      �� s���� 0 
randomword 
randomWord s  t u t o      ���� 0 	minlength 	minLength u  v�� v o      ���� 0 	maxlength 	maxLength��  ��   r l    ' w x y w k     ' z z  { | { r      } ~ } m        � � �   ~ o      ���� 0 s   |  � � � U    $ � � � r     � � � b     � � � o    ���� 0 s   � n     � � � 3    ��
�� 
cobj � m     � � � � � 4 a b c d e f g h i j k l m n o p q r s t u v w x y z � o      ���� 0 s   � l    ����� � I    ��� � � z����
�� .sysorandnmbr    ��� nmbr
�� misccura��   � �� � �
�� 
from � o    ���� 0 	minlength 	minLength � �� ���
�� 
to   � o    ���� 0 	maxlength 	maxLength��  ��  ��   �  ��� � L   % ' � � o   % &���� 0 s  ��   x R L TO DO: can this be turned into a genuinely useful test tool? if not, delete    y � � � �   T O   D O :   c a n   t h i s   b e   t u r n e d   i n t o   a   g e n u i n e l y   u s e f u l   t e s t   t o o l ?   i f   n o t ,   d e l e t e p  � � � l     ��������  ��  ��   �  � � � l     �� � ���   � J D--------------------------------------------------------------------    � � � � � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - �  � � � l     �� � ���   �   Timing/Profiling    � � � � "   T i m i n g / P r o f i l i n g �  � � � l     ��������  ��  ��   �  � � � i  - 0 � � � I     �� ���
�� .���:MTmrnull��� ��� ctxt � |���� ��� ���  ��   � o      ���� 0 nametext nameText��   � l      ����� � m       � � � � �  ��  ��  ��   � h     �� ��� 0 timerobject TimerObject � k       � �  � � � l     �� � ���   � � � note: AS can't serialize ASOC objects when [auto-]saving scripts, so store start and end times as NSTimeInterval (Double/real) to avoid any complaints    � � � �.   n o t e :   A S   c a n ' t   s e r i a l i z e   A S O C   o b j e c t s   w h e n   [ a u t o - ] s a v i n g   s c r i p t s ,   s o   s t o r e   s t a r t   a n d   e n d   t i m e s   a s   N S T i m e I n t e r v a l   ( D o u b l e / r e a l )   t o   a v o i d   a n y   c o m p l a i n t s �  � � � x     �� �����   � 4    �� �
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
�� boovtrue � o      �� 0 
_isrunning 
_isRunning �  � � � r    $ � � � n    � � � I    �~�}�|�~ @0 timeintervalsincereferencedate timeIntervalSinceReferenceDate�}  �|   � n    � � � o    �{�{ 0 nsdate NSDate � m    �z
�z misccura � o      �y�y 0 
_starttime 
_startTime �  ��x � L   % ' � �  f   % &�x   �  � � � l     �w�v�u�w  �v  �u   �  � � � i    � � � I      �t�s�r�t 0 	stoptimer 	stopTimer�s  �r   � k     8 � �  � � � Z     � ��q�p � H      � � o     �o�o 0 
_isrunning 
_isRunning � L   	  � � m   	 
�n�n  �q  �p   �  � � � r     � � � \     � � � l    ��m�l � n    � � � I    �k�j�i�k @0 timeintervalsincereferencedate timeIntervalSinceReferenceDate�j  �i   � n    � � � o    �h�h 0 nsdate NSDate � m    �g
�g misccura�m  �l   � o    �f�f 0 
_starttime 
_startTime � o      �e�e 0 elapsedtime elapsedTime �  � � � r     - �  � [     ' o     %�d�d 0 _totalseconds _totalSeconds o   % &�c�c 0 elapsedtime elapsedTime  o      �b�b 0 _totalseconds _totalSeconds �  r   . 5 m   . /�a
�a boovfals o      �`�` 0 
_isrunning 
_isRunning �_ L   6 8 o   6 7�^�^ 0 elapsedtime elapsedTime�_   � 	
	 l     �]�\�[�]  �\  �[  
  i    # I      �Z�Y�X�Z 0 elapsedtime elapsedTime�Y  �X   Z     �W o     �V�V 0 
_isrunning 
_isRunning L     \     l   �U�T n    I   	 �S�R�Q�S @0 timeintervalsincereferencedate timeIntervalSinceReferenceDate�R  �Q   o    	�P�P 0 nsdate NSDate�U  �T   o    �O�O 0 
_starttime 
_startTime�W   L     m    �N�N    l     �M�L�K�M  �L  �K   �J i  $ ' I      �I�H�G�I 0 	totaltime 	totalTime�H  �G   Z     �F  o     �E�E 0 
_isrunning 
_isRunning L    !! [    "#" o    �D�D 0 _totalseconds _totalSeconds# I    �C�B�A�C 0 elapsedtime elapsedTime�B  �A  �F    L    $$ o    �@�@ 0 _totalseconds _totalSeconds�J   � %&% l     �?�>�=�?  �>  �=  & '(' l     �<�;�:�<  �;  �:  ( )*) l     �9+,�9  + J D--------------------------------------------------------------------   , �-- � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -* ./. l     �801�8  0   Unit Test Framework   1 �22 (   U n i t   T e s t   F r a m e w o r k/ 343 l     �7�6�5�7  �6  �5  4 565 l     7897 j   1 3�4:�4 00 _abortedassertionerror _AbortedAssertionError: m   1 2�3�3A8 P J raised by `assert�` handlers upon failed assertion to terminate that test   9 �;; �   r a i s e d   b y   ` a s s e r t & `   h a n d l e r s   u p o n   f a i l e d   a s s e r t i o n   t o   t e r m i n a t e   t h a t   t e s t6 <=< l     �2�1�0�2  �1  �0  = >?> h   4 ;�/@�/ 00 _abortedassertiontoken _AbortedAssertionToken@ l     �.AB�.  A,& when raising error number AbortedAssertionError, the `from` parameter should carry this unique identifier to confirm error was raised by TestLib, and isn't merely an error in the test code/code being tested that happens to use the same error number (in which case it should be treated as such)   B �CCL   w h e n   r a i s i n g   e r r o r   n u m b e r   A b o r t e d A s s e r t i o n E r r o r ,   t h e   ` f r o m `   p a r a m e t e r   s h o u l d   c a r r y   t h i s   u n i q u e   i d e n t i f i e r   t o   c o n f i r m   e r r o r   w a s   r a i s e d   b y   T e s t L i b ,   a n d   i s n ' t   m e r e l y   a n   e r r o r   i n   t h e   t e s t   c o d e / c o d e   b e i n g   t e s t e d   t h a t   h a p p e n s   t o   u s e   t h e   s a m e   e r r o r   n u m b e r   ( i n   w h i c h   c a s e   i t   s h o u l d   b e   t r e a t e d   a s   s u c h )? DED l     �-�,�+�-  �,  �+  E FGF l     �*�)�(�*  �)  �(  G HIH l     �'JK�'  J L F the following are set/unset by __performunittestforsuite__ as it runs   K �LL �   t h e   f o l l o w i n g   a r e   s e t / u n s e t   b y   _ _ p e r f o r m u n i t t e s t f o r s u i t e _ _   a s   i t   r u n sI MNM l     �&�%�$�&  �%  �$  N OPO l     QRSQ j   < @�#T�# $0 _testsuiteobject _testSuiteObjectT m   < ?�"
�" 
msngR � � the test suite object that was passed to `perform unit test`; assigned and cleared at start and end of `perform unit test`; may be used by assert handlers (e.g. `assert test error` uses it when calling a `call_NAME` handler)   S �UU�   t h e   t e s t   s u i t e   o b j e c t   t h a t   w a s   p a s s e d   t o   ` p e r f o r m   u n i t   t e s t ` ;   a s s i g n e d   a n d   c l e a r e d   a t   s t a r t   a n d   e n d   o f   ` p e r f o r m   u n i t   t e s t ` ;   m a y   b e   u s e d   b y   a s s e r t   h a n d l e r s   ( e . g .   ` a s s e r t   t e s t   e r r o r `   u s e s   i t   w h e n   c a l l i n g   a   ` c a l l _ N A M E `   h a n d l e r )P VWV l     �!� ��!  �   �  W XYX l     Z[\Z j   A E�]� 0 _testreport _testReport] m   A D�
� 
msng[ x r a single test_NAME handler may perform multiple asserts, the result of each is recorded in TestReport object here   \ �^^ �   a   s i n g l e   t e s t _ N A M E   h a n d l e r   m a y   p e r f o r m   m u l t i p l e   a s s e r t s ,   t h e   r e s u l t   o f   e a c h   i s   r e c o r d e d   i n   T e s t R e p o r t   o b j e c t   h e r eY _`_ l     ����  �  �  ` aba l     cdec j   F J�f� $0 _testhandlername _testHandlerNamef m   F I�
� 
msngd R L used to generate default `call_NAME` handler name for a `test_NAME` handler   e �gg �   u s e d   t o   g e n e r a t e   d e f a u l t   ` c a l l _ N A M E `   h a n d l e r   n a m e   f o r   a   ` t e s t _ N A M E `   h a n d l e rb hih l     ����  �  �  i jkj j   K O�l� 0 
_skipsuite 
_SKIPSUITEl m   K N�� ck mnm l     ����  �  �  n opo l     ����  �  �  p qrq l     �st�  s  -------   t �uu  - - - - - - -r vwv l     �xy�  x ) # execute a single test_NAME handler   y �zz F   e x e c u t e   a   s i n g l e   t e s t _ N A M E   h a n d l e rw {|{ l     �
}~�
  } ] W (called by `osatest` via a code-generated glue handler it adds to the unittest script)   ~ � �   ( c a l l e d   b y   ` o s a t e s t `   v i a   a   c o d e - g e n e r a t e d   g l u e   h a n d l e r   i t   a d d s   t o   t h e   u n i t t e s t   s c r i p t )| ��� l     �	���	  �  �  � ��� i  P S��� I      ���� 0 __performunittestforsuite__  � ��� o      �� 0 suiteobject suiteObject� ��� J      �� ��� o      �� 0 	suitename 	suiteName� ��� o      �� 0 handlername handlerName� �� � o      ���� 0 isstyled isStyled�   �  �  � k    |�� ��� l      ������  �e_
		suiteObject : script -- test suite object
		suiteName : text -- test suite name, for reporting use
		handlerName : text -- name of the test suite handler to call
		allHandlerNames : list of text -- all handler names in this test suite; used to determine which if any fixture methods (configure_setUp, configure_tearDown, etc.) need to be called
		isStyled : boolean -- if true, the returned report will include special formatting codes (bold, underline) to improve presentation in Terminal.app and other VT100 emulators; use false if you intend to use this text elsewhere
		Result: script -- TestReport
	   � ���� 
 	 	 s u i t e O b j e c t   :   s c r i p t   - -   t e s t   s u i t e   o b j e c t 
 	 	 s u i t e N a m e   :   t e x t   - -   t e s t   s u i t e   n a m e ,   f o r   r e p o r t i n g   u s e 
 	 	 h a n d l e r N a m e   :   t e x t   - -   n a m e   o f   t h e   t e s t   s u i t e   h a n d l e r   t o   c a l l 
 	 	 a l l H a n d l e r N a m e s   :   l i s t   o f   t e x t   - -   a l l   h a n d l e r   n a m e s   i n   t h i s   t e s t   s u i t e ;   u s e d   t o   d e t e r m i n e   w h i c h   i f   a n y   f i x t u r e   m e t h o d s   ( c o n f i g u r e _ s e t U p ,   c o n f i g u r e _ t e a r D o w n ,   e t c . )   n e e d   t o   b e   c a l l e d 
 	 	 i s S t y l e d   :   b o o l e a n   - -   i f   t r u e ,   t h e   r e t u r n e d   r e p o r t   w i l l   i n c l u d e   s p e c i a l   f o r m a t t i n g   c o d e s   ( b o l d ,   u n d e r l i n e )   t o   i m p r o v e   p r e s e n t a t i o n   i n   T e r m i n a l . a p p   a n d   o t h e r   V T 1 0 0   e m u l a t o r s ;   u s e   f a l s e   i f   y o u   i n t e n d   t o   u s e   t h i s   t e x t   e l s e w h e r e 
 	 	 R e s u l t :   s c r i p t   - -   T e s t R e p o r t 
 	� ��� r     ��� n    ��� I    �������  0 maketestreport makeTestReport� ��� o    ���� 0 	suitename 	suiteName� ��� o    ���� 0 handlername handlerName� ���� o    ���� 0 isstyled isStyled��  ��  � o     ���� 0 _testsupport _TestSupport� o      ���� 0 _testreport _testReport� ��� l   ������  � = 7 check if this test (or entire suite) should be skipped   � ��� n   c h e c k   i f   t h i s   t e s t   ( o r   e n t i r e   s u i t e )   s h o u l d   b e   s k i p p e d� ��� Z   C������� n    ��� I     ������� 0 
hashandler 
hasHandler� ���� N    �� n    ��� o    ���� *0 configure_skiptests configure_skipTests� o    ���� 0 suiteobject suiteObject��  ��  � o    ���� 0 _supportlib _supportLib� Q   #?���� k   &�� ��� r   & -��� n  & +��� I   ' +�������� *0 configure_skiptests configure_skipTests��  ��  � o   & '���� 0 suiteobject suiteObject� o      ���� 0 skipinfo skipInfo� ��� Q   . Q���� l  1 4���� r   1 4��� o   1 2���� 0 skipinfo skipInfo� o      ���� 0 skipinfo skipInfo� > 8 make sure configure_skipTests actually returned a value   � ��� p   m a k e   s u r e   c o n f i g u r e _ s k i p T e s t s   a c t u a l l y   r e t u r n e d   a   v a l u e� R      �����
�� .ascrerr ****      � ****��  � �����
�� 
errn� d      �� m      ����
���  � k   < Q�� ��� R   < J����
�� .ascrerr ****      � ****� m   H I�� ��� �  c o n f i g u r e _ s k i p T e s t s    d i d n  t   r e t u r n   a n y t h i n g   ( e . g .   t o   r u n   a l l   t e s t s   i n   s u i t e ,   r e t u r n    m i s s i n g   v a l u e  ) .� ����
�� 
errn� m   > ?�����?� ����
�� 
erob� o   @ A���� 0 suiteobject suiteObject� �����
�� 
errt� J   B G�� ��� m   B C��
�� 
reco� ��� m   C D��
�� 
ctxt� ���� m   D E��
�� 
msng��  ��  � ���� L   K Q�� o   K P���� 0 _testreport _testReport��  � ���� Z   R������� >  R U��� o   R S���� 0 skipinfo skipInfo� m   S T��
�� 
msng� l  X���� Z   X������ n  X c��� I   ] c������� 0 istype isType� ��� o   ] ^���� 0 skipinfo skipInfo� ���� m   ^ _��
�� 
reco��  ��  � o   X ]���� 0 _testsupport _TestSupport� l  f ����� k   f ��� ��� r   f {��� c   f y��� l  f u������ n  f u��� I   p u������� 0 objectforkey_ objectForKey_� ���� o   p q���� 0 handlername handlerName��  ��  � l  f p������ n  f p� � I   k p������ 60 dictionarywithdictionary_ dictionaryWithDictionary_ �� o   k l���� 0 skipinfo skipInfo��  ��    n  f k o   g k���� 0 nsdictionary NSDictionary m   f g��
�� misccura��  ��  ��  ��  � m   u x��
�� 
****� o      ���� 0 
skipreason 
skipReason� �� Z   | ����� >  | 	 o   | }���� 0 
skipreason 
skipReason	 m   } ~��
�� 
msng k   � �

  Q   � � r   � � c   � � o   � ����� 0 
skipreason 
skipReason m   � ���
�� 
ctxt o      ���� 0 
skipreason 
skipReason R      ����
�� .ascrerr ****      � ****��   ����
�� 
errn d       m      �������   R   � ���
�� .ascrerr ****      � **** b   � � b   � � m   � � � f  c o n f i g u r e _ s k i p T e s t s    d i d n  t   r e t u r n   v a l i d   r e c o r d   (  o   � ����� 0 handlername handlerName m   � � �   h    p r o p e r t y   d o e s n  t   c o n t a i n   t e x t   o r    m i s s i n g   v a l u e  ) . ��!"
�� 
errn! m   � ������\" ��#$
�� 
erob# o   � ����� 0 skipinfo skipInfo$ ��%��
�� 
errt% J   � �&& '(' m   � ���
�� 
ctxt( )��) m   � ���
�� 
msng��  ��   *+* n  � �,-, I   � ���.���� 0 
addskipped 
addSkipped. /0/ o   � ����� 0 handlername handlerName0 1��1 o   � ����� 0 
skipreason 
skipReason��  ��  - o   � ����� 0 _testreport _testReport+ 2��2 L   � �33 o   � ����� 0 _testreport _testReport��  ��  ��  ��  � + % check if this test should be skipped   � �44 J   c h e c k   i f   t h i s   t e s t   s h o u l d   b e   s k i p p e d� 565 >  � �787 o   � ����� 0 skipinfo skipInfo8 m   � ���
�� 
msng6 9��9 l  � �:;<: k   � �== >?> Q   � �@AB@ r   � �CDC c   � �EFE o   � ����� 0 skipinfo skipInfoF m   � ���
�� 
ctxtD o      ���� 0 
skipreason 
skipReasonA R      ����G
�� .ascrerr ****      � ****��  G ��H��
�� 
errnH d      II m      �������  B R   � ���JK
�� .ascrerr ****      � ****J m   � �LL �MM �  c o n f i g u r e _ s k i p T e s t s    d i d n  t   r e t u r n   r e c o r d ,   t e x t ,   o r    m i s s i n g   v a l u e  .K ��NO
�� 
errnN m   � ������\O ��PQ
�� 
erobP o   � ����� 0 skipinfo skipInfoQ ��R��
�� 
errtR J   � �SS TUT m   � ���
�� 
recoU VWV m   � ���
�� 
ctxtW X��X m   � ���
�� 
msng��  ��  ? YZY n  � �[\[ I   � ���]���� 0 	skipsuite 	skipSuite] ^�^ o   � ��~�~ 0 
skipreason 
skipReason�  ��  \ o   � ��}�} 0 _testreport _testReportZ _�|_ L   � �`` o   � ��{�{ 0 _testreport _testReport�|  ;   skip the whole suite   < �aa *   s k i p   t h e   w h o l e   s u i t e��  ��  � L F (missing value = run test; text = skip suite; record = run/skip test)   � �bb �   ( m i s s i n g   v a l u e   =   r u n   t e s t ;   t e x t   =   s k i p   s u i t e ;   r e c o r d   =   r u n / s k i p   t e s t )��  ��  ��  � R      �zcd
�z .ascrerr ****      � ****c o      �y�y 0 etext eTextd �xef
�x 
errne o      �w�w 0 enumber eNumberf �vgh
�v 
erobg o      �u�u 0 efrom eFromh �tij
�t 
errti o      �s�s 
0 eto eToj �rk�q
�r 
ptlrk o      �p�p 0 epartial ePartial�q  � k  ?ll mnm n 8opo I  8�oq�n�o 0 	addbroken 	addBrokenq rsr m  tt �uu & c o n f i g u r e _ s k i p T e s t ss vwv m  xx �yy $ b r o k e   d u e   t o   e r r o rw z{z m  || �}}  { ~�m~ l 	2�l�k J  2�� ��j� J  0�� ��� m  �� ���   u n e x p e c t e d   e r r o r� ��i� n .��� I  #.�h��g�h .0 makecaughterrorrecord makeCaughtErrorRecord� ��� o  #$�f�f 0 etext eText� ��� o  $%�e�e 0 enumber eNumber� ��� o  %&�d�d 0 efrom eFrom� ��� o  &'�c�c 
0 eto eTo� ��b� o  '(�a�a 0 epartial ePartial�b  �g  � o  #�`�` 0 _testsupport _TestSupport�i  �j  �l  �k  �m  �n  p o  �_�_ 0 _testreport _testReportn ��^� L  9?�� o  9>�]�] 0 _testreport _testReport�^  ��  ��  � ��� l DD�\���\  �   pre-test preparation   � ��� *   p r e - t e s t   p r e p a r a t i o n� ��� r  DK��� o  DE�[�[ 0 suiteobject suiteObject� o      �Z�Z $0 _testsuiteobject _testSuiteObject� ��� r  LS��� o  LM�Y�Y 0 handlername handlerName� o      �X�X $0 _testhandlername _testHandlerName� ��� l TT�W���W  �/) note: while `osatest` could supply a list of found handler names to check for existence of `configure_setUp` and `configure_tearDown`, that would only work for configure_setUp/configure_tearDown handlers defined directly within the suite script, not configure_setUp/configure_tearDown handlers inherited from a parent script; thus it's necessary to resort here to some undocumented hackery to determine existence of callable configure_setUp/configure_tearDown handlers before trying to call them (see also comments on `hasHandler` in LibrarySupportLib)   � ���R   n o t e :   w h i l e   ` o s a t e s t `   c o u l d   s u p p l y   a   l i s t   o f   f o u n d   h a n d l e r   n a m e s   t o   c h e c k   f o r   e x i s t e n c e   o f   ` c o n f i g u r e _ s e t U p `   a n d   ` c o n f i g u r e _ t e a r D o w n ` ,   t h a t   w o u l d   o n l y   w o r k   f o r   c o n f i g u r e _ s e t U p / c o n f i g u r e _ t e a r D o w n   h a n d l e r s   d e f i n e d   d i r e c t l y   w i t h i n   t h e   s u i t e   s c r i p t ,   n o t   c o n f i g u r e _ s e t U p / c o n f i g u r e _ t e a r D o w n   h a n d l e r s   i n h e r i t e d   f r o m   a   p a r e n t   s c r i p t ;   t h u s   i t ' s   n e c e s s a r y   t o   r e s o r t   h e r e   t o   s o m e   u n d o c u m e n t e d   h a c k e r y   t o   d e t e r m i n e   e x i s t e n c e   o f   c a l l a b l e   c o n f i g u r e _ s e t U p / c o n f i g u r e _ t e a r D o w n   h a n d l e r s   b e f o r e   t r y i n g   t o   c a l l   t h e m   ( s e e   a l s o   c o m m e n t s   o n   ` h a s H a n d l e r `   i n   L i b r a r y S u p p o r t L i b )� ��� Z  T����V�U� n Tc��� I  Yc�T��S�T 0 
hashandler 
hasHandler� ��R� N  Y_�� n  Y^��� o  Z^�Q�Q "0 configure_setup configure_setUp� o  YZ�P�P 0 suiteobject suiteObject�R  �S  � o  TY�O�O 0 _supportlib _supportLib� Q  f����� n in��� I  jn�N�M�L�N "0 configure_setup configure_setUp�M  �L  � o  ij�K�K 0 suiteobject suiteObject� R      �J��
�J .ascrerr ****      � ****� o      �I�I 0 etext eText� �H��
�H 
errn� o      �G�G 0 enumber eNumber� �F��
�F 
erob� o      �E�E 0 efrom eFrom� �D��
�D 
errt� o      �C�C 
0 eto eTo� �B��A
�B 
ptlr� o      �@�@ 0 epartial ePartial�A  � k  v��� ��� n v���� I  {��?��>�? 0 	addbroken 	addBroken� ��� m  {~�� ���  c o n f i g u r e _ s e t U p� ��� m  ~��� ��� $ b r o k e   d u e   t o   e r r o r� ��� m  ���� ���  � ��=� l 	����<�;� J  ���� ��:� J  ���� ��� m  ���� ���   u n e x p e c t e d   e r r o r� ��9� n ����� I  ���8��7�8 .0 makecaughterrorrecord makeCaughtErrorRecord� ��� o  ���6�6 0 etext eText� ��� o  ���5�5 0 enumber eNumber� ��� o  ���4�4 0 efrom eFrom� ��� o  ���3�3 
0 eto eTo� ��2� o  ���1�1 0 epartial ePartial�2  �7  � o  ���0�0 0 _testsupport _TestSupport�9  �:  �<  �;  �=  �>  � o  v{�/�/ 0 _testreport _testReport� ��� r  ����� m  ���.
�. 
msng� o      �-�- $0 _testsuiteobject _testSuiteObject� ��,� L  ���� o  ���+�+ 0 _testreport _testReport�,  �V  �U  � ��� r  ����� n ����� I  ���*��)�*  0 makecallobject makeCallObject� ��� o  ���(�( 0 handlername handlerName� ��'� m  ���&�&  �'  �)  � o  ���%�% 0 _testsupport _TestSupport� o      �$�$ 0 
callobject 
callObject� ��� l ���#���#  �   do test   � ���    d o   t e s t� ��� Q  �   n �� I  ���"�!�" 0 dotest doTest  o  ��� �  0 suiteobject suiteObject � m  ���
� 
msng�  �!   o  ���� 0 
callobject 
callObject R      �	

� .ascrerr ****      � ****	 o      �� 0 etext eText
 �
� 
errn o      �� 0 enumber eNumber �
� 
erob o      �� 0 efrom eFrom �
� 
errt o      �� 
0 eto eTo ��
� 
ptlr o      �� 0 epartial ePartial�   l � Z  ��� H  �� l ���� F  �� =  �� o  ���� 0 enumber eNumber o  ���� 00 _abortedassertionerror _AbortedAssertionError = �� o  ���� 0 efrom eFrom o  ���
�
 00 _abortedassertiontoken _AbortedAssertionToken�  �   l � ! l �"#$" n �%&% I  ��	'��	 0 
addfailure 
addFailure' ()( o  ���� 0 handlername handlerName) *+* m  ��,, �-- j ( e . g .   e r r o r   i n   c o d e   b e i n g   t e s t e d / b u g   i n   t e s t   h a n d l e r )+ ./. m  ��00 �11  / 2�2 l 	�3��3 J  �44 5�5 J  �66 787 m  ��99 �::   u n e x p e c t e d   e r r o r8 ;�; n �<=< I  �>� � .0 makecaughterrorrecord makeCaughtErrorRecord> ?@? o  ���� 0 etext eText@ ABA o  ���� 0 enumber eNumberB CDC o  ���� 0 efrom eFromD EFE o  ���� 
0 eto eToF G��G o  ���� 0 epartial ePartial��  �   = o  ����� 0 _testsupport _TestSupport�  �  �  �  �  �  & o  ������ 0 _testreport _testReport#�� TO DO: without stack trace support, there's no way to distinguish an error raised by the code being tested versus an error caused by a bug in the test code, so we can only say error was 'unexpected' and leave user to figure out why; allowing `call_NAME` handlers to be used by `assert test result` would give users the opportunity to box up the code being tested allowing TestLib to distinguish the cause   $ �HH*   T O   D O :   w i t h o u t   s t a c k   t r a c e   s u p p o r t ,   t h e r e ' s   n o   w a y   t o   d i s t i n g u i s h   a n   e r r o r   r a i s e d   b y   t h e   c o d e   b e i n g   t e s t e d   v e r s u s   a n   e r r o r   c a u s e d   b y   a   b u g   i n   t h e   t e s t   c o d e ,   s o   w e   c a n   o n l y   s a y   e r r o r   w a s   ' u n e x p e c t e d '   a n d   l e a v e   u s e r   t o   f i g u r e   o u t   w h y ;   a l l o w i n g   ` c a l l _ N A M E `   h a n d l e r s   t o   b e   u s e d   b y   ` a s s e r t   t e s t   r e s u l t `   w o u l d   g i v e   u s e r s   t h e   o p p o r t u n i t y   t o   b o x   u p   t h e   c o d e   b e i n g   t e s t e d   a l l o w i n g   T e s t L i b   t o   d i s t i n g u i s h   t h e   c a u s e  � � check if failure was already reported, and this is the subsequent abort, in which case ignore; if not, it's an error in either the test_NAME handler or the code being tested, so report it   ! �IIx   c h e c k   i f   f a i l u r e   w a s   a l r e a d y   r e p o r t e d ,   a n d   t h i s   i s   t h e   s u b s e q u e n t   a b o r t ,   i n   w h i c h   c a s e   i g n o r e ;   i f   n o t ,   i t ' s   a n   e r r o r   i n   e i t h e r   t h e   t e s t _ N A M E   h a n d l e r   o r   t h e   c o d e   b e i n g   t e s t e d ,   s o   r e p o r t   i t�  �     test failed    �JJ    t e s t   f a i l e d� KLK l ��MN��  M   post-test clean up   N �OO &   p o s t - t e s t   c l e a n   u pL PQP Z  mRS����R n +TUT I  !+��V���� 0 
hashandler 
hasHandlerV W��W N  !'XX n  !&YZY o  "&���� (0 configure_teardown configure_tearDownZ o  !"���� 0 suiteobject suiteObject��  ��  U o  !���� 0 _supportlib _supportLibS Q  .i[\][ n 16^_^ I  26�������� (0 configure_teardown configure_tearDown��  ��  _ o  12���� 0 suiteobject suiteObject\ R      ��`a
�� .ascrerr ****      � ****` o      ���� 0 etext eTexta ��bc
�� 
errnb o      ���� 0 enumber eNumberc ��de
�� 
erobd o      ���� 0 efrom eFrome ��fg
�� 
errtf o      ���� 
0 eto eTog ��h��
�� 
ptlrh o      ���� 0 epartial ePartial��  ] n >iiji I  Ci��k���� 0 	addbroken 	addBrokenk lml m  CFnn �oo $ c o n f i g u r e _ t e a r D o w nm pqp m  FIrr �ss $ b r o k e   d u e   t o   e r r o rq tut m  ILvv �ww  u x��x l 	Lcy����y J  Lczz {��{ J  La|| }~} m  LO ���   u n e x p e c t e d   e r r o r~ ���� n O_��� I  T_������� .0 makecaughterrorrecord makeCaughtErrorRecord� ��� o  TU���� 0 etext eText� ��� o  UV���� 0 enumber eNumber� ��� o  VW���� 0 efrom eFrom� ��� o  WX���� 
0 eto eTo� ���� o  XY���� 0 epartial ePartial��  ��  � o  OT���� 0 _testsupport _TestSupport��  ��  ��  ��  ��  ��  j o  >C���� 0 _testreport _testReport��  ��  Q ��� r  nu��� m  no��
�� 
msng� o      ���� $0 _testsuiteobject _testSuiteObject� ���� l v|���� L  v|�� o  v{���� 0 _testreport _testReport��{ TO DO: wrapping all the test data (result values, error info, status, etc) in a script object and returning that preserves AS context info and AS types across the AE bridge; the script object can then be loaded into a new OSAID and its methods called to extract each bit of data in turn for formatting and final message generation  (caveat not sure what ocids and optrs will do)   � ����   T O   D O :   w r a p p i n g   a l l   t h e   t e s t   d a t a   ( r e s u l t   v a l u e s ,   e r r o r   i n f o ,   s t a t u s ,   e t c )   i n   a   s c r i p t   o b j e c t   a n d   r e t u r n i n g   t h a t   p r e s e r v e s   A S   c o n t e x t   i n f o   a n d   A S   t y p e s   a c r o s s   t h e   A E   b r i d g e ;   t h e   s c r i p t   o b j e c t   c a n   t h e n   b e   l o a d e d   i n t o   a   n e w   O S A I D   a n d   i t s   m e t h o d s   c a l l e d   t o   e x t r a c t   e a c h   b i t   o f   d a t a   i n   t u r n   f o r   f o r m a t t i n g   a n d   f i n a l   m e s s a g e   g e n e r a t i o n     ( c a v e a t   n o t   s u r e   w h a t   o c i d s   a n d   o p t r s   w i l l   d o )��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ������  � J D--------------------------------------------------------------------   � ��� � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -� ��� l     ������  �   Unit Test Comparators   � ��� ,   U n i t   T e s t   C o m p a r a t o r s� ��� l     ��������  ��  ��  � ��� l     ������  �   result checking   � ���     r e s u l t   c h e c k i n g� ��� l     ��������  ��  ��  � ��� i  T W��� I     ������
�� .���:ExEqnull��� ��� null��  ��  � h     ����� (0 exactequalitycheck ExactEqualityCheck� i    ��� I      �������  0 compareobjects compareObjects� ��� o      ���� 0 expectederror expectedError� ���� o      ���� 0 actualerror actualError��  ��  � P     ���� k    �� ��� l   ������  � l f also check types are identical, e.g. if unittest indicates a real is expected then integer is a smell   � ��� �   a l s o   c h e c k   t y p e s   a r e   i d e n t i c a l ,   e . g .   i f   u n i t t e s t   i n d i c a t e s   a   r e a l   i s   e x p e c t e d   t h e n   i n t e g e r   i s   a   s m e l l� ��� Z   ������� >   ��� n    ��� m    ��
�� 
pcls� o    ���� 0 expectederror expectedError� n    ��� m   	 ��
�� 
pcls� o    	���� 0 actualerror actualError� L    �� m    ��
�� boovfals��  ��  � ���� L    �� =   ��� o    ���� 0 expectederror expectedError� o    ���� 0 actualerror actualError��  � ���
�� conscase� ���
�� consdiac� ���
�� conshyph� ���
�� conspunc� ����
�� conswhit��  � ����
�� consnume��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  X [��� I     ������
�� .���:NmEqnull��� ��� null��  ��  � l    ���� h     ����� 00 numericalequalitycheck NumericalEqualityCheck� k      �� ��� j     ����� 0 _isequaldelta _isEqualDelta� m     �� >.�&֕� ���� i   ��� I      �������  0 compareobjects compareObjects� ��� o      ���� 0 expectederror expectedError� ���� o      ���� 0 actualerror actualError��  ��  � k     .�� ��� l     ������  � R L TO DO: needs to check if two integers, else if two reals, else return false   � ��� �   T O   D O :   n e e d s   t o   c h e c k   i f   t w o   i n t e g e r s ,   e l s e   i f   t w o   r e a l s ,   e l s e   r e t u r n   f a l s e� ��� Z    ������� >     ��� l    
������ I    
����
�� .corecnte****       ****� J     �� ��� o     ���� 0 expectederror expectedError�  ��  o    ���� 0 actualerror actualError��  � ����
�� 
kocl m    ��
�� 
nmbr��  ��  ��  � m   
 ���� � L     m    ��
�� boovfals��  ��  � �� l   . L    . F    -	 l   
��~
 A     \     o    �}�} 0 expectederror expectedError o    �|�| 0 _isequaldelta _isEqualDelta o    �{�{ 0 actualerror actualError�  �~  	 l  " +�z�y ?   " + [   " ) o   " #�x�x 0 expectederror expectedError o   # (�w�w 0 _isequaldelta _isEqualDelta o   ) *�v�v 0 actualerror actualError�z  �y  :4 TO DO: FIX! (i.e. these calculations are incorrect: the min & max bounds need to be calculated as -9DP *relative* to the given value, otherwise 'imprecisely identical' large numbers will always compare as false while significantly different small numbers will always compare as true); see also MathLib TODOs    �h   T O   D O :   F I X !   ( i . e .   t h e s e   c a l c u l a t i o n s   a r e   i n c o r r e c t :   t h e   m i n   &   m a x   b o u n d s   n e e d   t o   b e   c a l c u l a t e d   a s   - 9 D P   * r e l a t i v e *   t o   t h e   g i v e n   v a l u e ,   o t h e r w i s e   ' i m p r e c i s e l y   i d e n t i c a l '   l a r g e   n u m b e r s   w i l l   a l w a y s   c o m p a r e   a s   f a l s e   w h i l e   s i g n i f i c a n t l y   d i f f e r e n t   s m a l l   n u m b e r s   w i l l   a l w a y s   c o m p a r e   a s   t r u e ) ;   s e e   a l s o   M a t h L i b   T O D O s��  ��  � ? 9 allows for limited precision when comparing real numbers   � � r   a l l o w s   f o r   l i m i t e d   p r e c i s i o n   w h e n   c o m p a r i n g   r e a l   n u m b e r s�  l     �u�t�s�u  �t  �s    l     �r�q�p�r  �q  �p    j   \ b�o�o .0 _defaultequalitycheck _defaultEqualityCheck I  \ a�n�m�l
�n .���:ExEqnull��� ��� null�m  �l    l     �k�j�i�k  �j  �i     l     �h!"�h  !  -----   " �## 
 - - - - -  $%$ l     �g&'�g  &   error checking   ' �((    e r r o r   c h e c k i n g% )*) l     �f�e�d�f  �e  �d  * +,+ j   c ~�c-�c :0 _defaulterrorpropertychecks _defaultErrorPropertyChecks- K   c {.. �b/0�b 0 	errortext 	errorText/ o   f g�a�a .0 _defaultequalitycheck _defaultEqualityCheck0 �`12�` 0 errornumber errorNumber1 o   j k�_�_ .0 _defaultequalitycheck _defaultEqualityCheck2 �^34�^ 0 
errorvalue 
errorValue3 o   n o�]�] .0 _defaultequalitycheck _defaultEqualityCheck4 �\56�\ 0 expectedtype expectedType5 o   r s�[�[ .0 _defaultequalitycheck _defaultEqualityCheck6 �Z7�Y�Z 0 partialresult partialResult7 o   v w�X�X .0 _defaultequalitycheck _defaultEqualityCheck�Y  , 898 l     �W�V�U�W  �V  �U  9 :;: l     �T�S�R�T  �S  �R  ; <=< i   �>?> I     �Q�P@
�Q .���:ExErnull��� ��� null�P  @ �OA�N
�O 
UsinA |�M�LB�KC�M  �L  B o      �J�J  0 propertychecks propertyChecks�K  C J      �I�I  �N  ? k     ODD EFE Q     GGHIG k    5JJ KLK r    MNM n   OPO I    �HQ�G�H &0 asrecordparameter asRecordParameterQ RSR o    	�F�F  0 propertychecks propertyChecksS T�ET m   	 
UU �VV 
 u s i n g�E  �G  P o    �D�D 0 _supportlib _supportLibN o      �C�C  0 propertychecks propertyChecksL WXW r    YZY b    [\[ o    �B�B  0 propertychecks propertyChecks\ o    �A�A :0 _defaulterrorpropertychecks _defaultErrorPropertyChecksZ o      �@�@ 0 checkobjects checkObjectsX ]�?] l   5^_`^ Z   5ab�>�=a >    &cdc n    efe 1    �<
�< 
lengf o    �;�; 0 checkobjects checkObjectsd n    %ghg 1   # %�:
�: 
lengh o    #�9�9 :0 _defaulterrorpropertychecks _defaultErrorPropertyChecksb R   ) 1�8ij
�8 .ascrerr ****      � ****i m   / 0kk �ll � I n v a l i d    u s i n g    p a r a m e t e r   ( r e c o r d   c o n t a i n s   o n e   o r   m o r e   u n r e c o g n i z e d   p r o p e r t i e s ) .j �7mn
�7 
errnm m   + ,�6�6�Yn �5o�4
�5 
erobo o   - .�3�3  0 propertychecks propertyChecks�4  �>  �=  _ � � (note: this doesn't bother to check each property's type or that each object has a �compareObjects� handler as any problems there will raise errors if/when those error attributes are checked)   ` �pp�   ( n o t e :   t h i s   d o e s n ' t   b o t h e r   t o   c h e c k   e a c h   p r o p e r t y ' s   t y p e   o r   t h a t   e a c h   o b j e c t   h a s   a    c o m p a r e O b j e c t s    h a n d l e r   a s   a n y   p r o b l e m s   t h e r e   w i l l   r a i s e   e r r o r s   i f / w h e n   t h o s e   e r r o r   a t t r i b u t e s   a r e   c h e c k e d )�?  H R      �2qr
�2 .ascrerr ****      � ****q o      �1�1 0 etext eTextr �0st
�0 
errns o      �/�/ 0 enumber eNumbert �.uv
�. 
erobu o      �-�- 0 efrom eFromv �,w�+
�, 
errtw o      �*�* 
0 eto eTo�+  I I   = G�)x�(�) 
0 _error  x yzy m   > ?{{ �|| " e x a c t   e r r o r   c h e c kz }~} o   ? @�'�' 0 etext eText~ � o   @ A�&�& 0 enumber eNumber� ��� o   A B�%�% 0 efrom eFrom� ��$� o   B C�#�# 
0 eto eTo�$  �(  F ��"� h   H O�!��! "0 exacterrorcheck ExactErrorCheck� i    ��� I      � ���   0 compareobjects compareObjects� ��� o      �� 0 expectederror expectedError� ��� o      �� 0 actualerror actualError�  �  � k     ��� ��� l     ����  � � note: `assert test error` normalizes the `expectedError` record prior to calling compareObjects so it will always contain the following properties; any properties that were not supplied by the test script will contain the unique script object `NoValue`   � ����   n o t e :   ` a s s e r t   t e s t   e r r o r `   n o r m a l i z e s   t h e   ` e x p e c t e d E r r o r `   r e c o r d   p r i o r   t o   c a l l i n g   c o m p a r e O b j e c t s   s o   i t   w i l l   a l w a y s   c o n t a i n   t h e   f o l l o w i n g   p r o p e r t i e s ;   a n y   p r o p e r t i e s   t h a t   w e r e   n o t   s u p p l i e d   b y   t h e   t e s t   s c r i p t   w i l l   c o n t a i n   t h e   u n i q u e   s c r i p t   o b j e c t   ` N o V a l u e `� ��� X     ����� k   \ ��� ��� r   \ s��� o   \ ]�� 0 aref aRef� J      �� ��� o      �� $0 expectedproperty expectedProperty� ��� o      ��  0 actualproperty actualProperty� ��� o      �� 0 checkobject checkObject�  � ��� Z   t ������ >  t }��� o   t u�� $0 expectedproperty expectedProperty� n  u |��� o   z |�� 0 novalue NoValue� o   u z�� 0 _testsupport _TestSupport� Z  � ������ =  � ���� n  � ���� I   � �����  0 compareobjects compareObjects� ��� o   � ��
�
 $0 expectedproperty expectedProperty� ��	� o   � ���  0 actualproperty actualProperty�	  �  � o   � ��� 0 checkobject checkObject� m   � ��
� boovfals� L   � ��� m   � ��
� boovfals�  �  �  �  �  � 0 aref aRef� J    P�� ��� l 	  ���� J    �� ��� n   ��� o    �� 0 errornumber errorNumber� o    �� 0 expectederror expectedError� ��� n   	��� o    	� �  0 errornumber errorNumber� o    ���� 0 actualerror actualError� ���� n   	 ��� o    ���� 0 errornumber errorNumber� o   	 ���� 0 checkobjects checkObjects��  �  �  � ��� l 	  !������ J    !�� ��� n   ��� o    ���� 0 	errortext 	errorText� o    ���� 0 expectederror expectedError� ��� n   ��� o    ���� 0 	errortext 	errorText� o    ���� 0 actualerror actualError� ���� n    ��� o    ���� 0 	errortext 	errorText� o    ���� 0 checkobjects checkObjects��  ��  ��  � ��� l 	 ! 0������ J   ! 0�� ��� n  ! $��� o   " $���� 0 
errorvalue 
errorValue� o   ! "���� 0 expectederror expectedError� ��� n  $ '��� o   % '���� 0 
errorvalue 
errorValue� o   $ %���� 0 actualerror actualError� ���� n   ' .��� o   , .���� 0 
errorvalue 
errorValue� o   ' ,���� 0 checkobjects checkObjects��  ��  ��  � ��� l 	 0 ?������ J   0 ?�� ��� n  0 3��� o   1 3���� 0 expectedtype expectedType� o   0 1���� 0 expectederror expectedError� ��� n  3 6��� o   4 6���� 0 expectedtype expectedType� o   3 4���� 0 actualerror actualError� ���� n   6 =��� o   ; =���� 0 expectedtype expectedType� o   6 ;���� 0 checkobjects checkObjects��  ��  ��  � ���� l 	 ? N������ l 
 ? N������ J   ? N�� ��� n  ? B��� o   @ B���� 0 partialresult partialResult� o   ? @���� 0 expectederror expectedError� ��� n  B E��� o   C E���� 0 partialresult partialResult� o   B C���� 0 actualerror actualError� ���� n   E L��� o   J L���� 0 partialresult partialResult� o   E J���� 0 checkobjects checkObjects��  ��  ��  ��  ��  ��  � ���� L   � �   m   � ���
�� boovtrue��  �"  =  l     ��������  ��  ��    l     ��������  ��  ��    j   � ����� (0 _defaulterrorcheck _defaultErrorCheck I  � �������
�� .���:ExErnull��� ��� null��  ��   	 l     ��������  ��  ��  	 

 l     ��������  ��  ��    l     ����   J D--------------------------------------------------------------------    � � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  l     ����     Unit Test Assertions     � ,   U n i t   T e s t   A s s e r t i o n s    l     ��������  ��  ��    i  � � I     ����
�� .���:AsRenull��� ��� null��   ��
�� 
Valu o      ���� 0 actualresult actualResult �� 
�� 
Equa o      ����  0 expectedresult expectedResult  ��!"
�� 
Summ! |����#��$��  ��  # o      ���� 0 usernote userNote��  $ l     %����% m      && �''  ��  ��  " ��(��
�� 
Usin( |����)��*��  ��  ) o      ���� 0 checkobject checkObject��  * l     +����+ m      ��
�� 
msng��  ��  ��   k    B,, -.- Z    /0����/ =    121 o     ���� $0 _testsuiteobject _testSuiteObject2 m    ��
�� 
msng0 R   
 ��34
�� .ascrerr ****      � ****3 m    55 �66 d C a n n o t    a s s e r t   t e s t   r e s u l t    o u t s i d e   o f   u n i t   t e s t s .4 ��7��
�� 
errn7 m    �����T��  ��  ��  . 8��8 P   B9:;9 k   A<< =>= Q    �?@A? k    hBB CDC r    *EFE n   (GHG I   " (��I���� "0 astextparameter asTextParameterI JKJ o   " #���� 0 usernote userNoteK L��L m   # $MM �NN  s u m m a r y��  ��  H o    "���� 0 _supportlib _supportLibF o      ���� 0 usernote userNoteD OPO Z  + <QR����Q =  + .STS o   + ,���� 0 checkobject checkObjectT m   , -��
�� 
msngR r   1 8UVU o   1 6���� .0 _defaultequalitycheck _defaultEqualityCheckV o      ���� 0 checkobject checkObject��  ��  P WXW r   = JYZY n  = H[\[ I   B H��]���� &0 asscriptparameter asScriptParameter] ^_^ o   B C���� 0 checkobject checkObject_ `��` m   C Daa �bb 
 u s i n g��  ��  \ o   = B���� 0 _supportlib _supportLibZ o      ���� 0 checkobject checkObjectX c��c Z  K hde����d H   K Yff n  K Xghg I   P X��i���� 0 
hashandler 
hasHandleri j��j N   P Tkk n   P Slml o   Q S����  0 compareobjects compareObjectsm o   P Q���� 0 checkobject checkObject��  ��  h o   K P���� 0 _supportlib _supportLibe R   \ d��no
�� .ascrerr ****      � ****n m   b cpp �qq � B a d    u s i n g    p a r a m e t e r   ( s c r i p t   o b j e c t   d o e s n  t   c o n t a i n   a    c o m p a r e O b j e c t s    h a n d l e r ) .o ��rs
�� 
errnr m   ^ _�����@s ��t�
�� 
erobt o   ` a�~�~ 0 checkobject checkObject�  ��  ��  ��  @ R      �}uv
�} .ascrerr ****      � ****u o      �|�| 0 etext eTextv �{wx
�{ 
errnw o      �z�z 0 enumber eNumberx �yyz
�y 
eroby o      �x�x 0 efrom eFromz �w{|
�w 
errt{ o      �v�v 
0 eto eTo| �u}�t
�u 
ptlr} o      �s�s 0 epartial ePartial�t  A k   p �~~ � n  p ���� I   u ��r��q�r 0 	addbroken 	addBroken� ��� m   u x�� ��� $ a s s e r t   t e s t   r e s u l t� ��� m   x {�� ��� . r e c e i v e d   b a d   p a r a m e t e r s� ��� o   { |�p�p 0 usernote userNote� ��o� l 	 | ���n�m� J   | ��� ��l� J   | ��� ��� m   | �� ���   u n e x p e c t e d   e r r o r� ��k� n   ���� I   � ��j��i�j .0 makecaughterrorrecord makeCaughtErrorRecord� ��� o   � ��h�h 0 etext eText� ��� o   � ��g�g 0 enumber eNumber� ��� o   � ��f�f 0 efrom eFrom� ��� o   � ��e�e 
0 eto eTo� ��d� o   � ��c�c 0 epartial ePartial�d  �i  � o    ��b�b 0 _testsupport _TestSupport�k  �l  �n  �m  �o  �q  � o   p u�a�a 0 _testreport _testReport� ��`� R   � ��_�^�
�_ .ascrerr ****      � ****�^  � �]��
�] 
errn� o   � ��\�\ 00 _abortedassertionerror _AbortedAssertionError� �[��Z
�[ 
erob� o   � ��Y�Y 00 _abortedassertiontoken _AbortedAssertionToken�Z  �`  > ��� Q   � ����� r   � ���� n  � ���� I   � ��X��W�X  0 compareobjects compareObjects� ��� o   � ��V�V  0 expectedresult expectedResult� ��U� o   � ��T�T 0 actualresult actualResult�U  �W  � o   � ��S�S 0 checkobject checkObject� o      �R�R 0 isequal isEqual� R      �Q��
�Q .ascrerr ****      � ****� o      �P�P 0 etext eText� �O��
�O 
errn� o      �N�N 0 enumber eNumber� �M��
�M 
erob� o      �L�L 0 efrom eFrom� �K��
�K 
errt� o      �J�J 
0 eto eTo� �I��H
�I 
ptlr� o      �G�G 0 epartial ePartial�H  � k   � ��� ��� n  � ���� I   � ��F��E�F 0 	addbroken 	addBroken� ��� m   � ��� ��� $ a s s e r t   t e s t   r e s u l t� ��� m   � ��� ��� D b r o k e   d u e   t o   e r r o r   i n   c h e c k   o b j e c t� ��� o   � ��D�D 0 usernote userNote� ��C� l 	 � ���B�A� J   � ��� ��@� J   � ��� ��� m   � ��� ���   u n e x p e c t e d   e r r o r� ��?� n  � ���� I   � ��>��=�> .0 makecaughterrorrecord makeCaughtErrorRecord� ��� o   � ��<�< 0 etext eText� ��� o   � ��;�; 0 enumber eNumber� ��� o   � ��:�: 0 efrom eFrom� ��� o   � ��9�9 
0 eto eTo� ��8� o   � ��7�7 0 epartial ePartial�8  �=  � o   � ��6�6 0 _testsupport _TestSupport�?  �@  �B  �A  �C  �E  � o   � ��5�5 0 _testreport _testReport� ��4� R   � ��3�2�
�3 .ascrerr ****      � ****�2  � �1��
�1 
errn� o   � ��0�0 00 _abortedassertionerror _AbortedAssertionError� �/��.
�/ 
erob� o   � ��-�- 00 _abortedassertiontoken _AbortedAssertionToken�.  �4  � ��� r   ���� J   ��� ��� J   � ��� ��� m   � ��� ���  e x p e c t e d   r e s u l t� ��,� o   � ��+�+  0 expectedresult expectedResult�,  � ��*� J   ��� ��� m   � ��� ���  a c t u a l   r e s u l t� ��)� o   � �(�( 0 actualresult actualResult�)  �*  � o      �'�' 0 testdata testData� ��&� Z  A� �%� o  �$�$ 0 isequal isEqual  k    n  I  �#�"�# 0 
addsuccess 
addSuccess 	 m  

 � $ a s s e r t   t e s t   r e s u l t	  o  �!�! 0 usernote userNote �  o  �� 0 testdata testData�   �"   o  �� 0 _testreport _testReport � L  ��  �  �%   k  A  n 0 I  $0��� 0 
addfailure 
addFailure  m  $' � $ a s s e r t   t e s t   r e s u l t  m  '* � 2 r e c e i v e d   i n c o r r e c t   r e s u l t  o  *+�� 0 usernote userNote  �  o  +,�� 0 testdata testData�  �   o  $�� 0 _testreport _testReport !�! R  1A��"
� .ascrerr ****      � ****�  " �#$
� 
errn# o  38�� 00 _abortedassertionerror _AbortedAssertionError$ �%�
� 
erob% o  9>�� 00 _abortedassertiontoken _AbortedAssertionToken�  �  �&  : �&
� conscase& �'
� consdiac' �(
� conshyph( �
)
�
 conspunc) �	�
�	 conswhit�  ; ��
� consnume�  ��   *+* l     ����  �  �  + ,-, l     ��� �  �  �   - ./. i  � �010 I     ����2
�� .���:AsErnull��� ��� null��  2 ��34
�� 
Hand3 |����5��6��  ��  5 o      ���� "0 callhandlername callHandlerName��  6 l     7����7 m      88 �99  ��  ��  4 ��:;
�� 
Args: |����<��=��  ��  < o      ����  0 parametervalue parameterValue��  = l     >����> m      ��
�� 
���!��  ��  ; ��?@
�� 
Equa? o      ���� 0 expectederror expectedError@ ��AB
�� 
SummA |����C��D��  ��  C o      ���� 0 usernote userNote��  D l     E����E m      FF �GG  ��  ��  B ��H��
�� 
UsinH |����I��J��  ��  I o      ���� 0 checkobject checkObject��  J l     K����K m      ��
�� 
msng��  ��  ��  1 k    �LL MNM Z    OP����O =    QRQ o     ���� $0 _testsuiteobject _testSuiteObjectR m    ��
�� 
msngP R   
 ��ST
�� .ascrerr ****      � ****S m    UU �VV b C a n n o t    a s s e r t   t e s t   e r r o r    o u t s i d e   o f   u n i t   t e s t s .T ��W��
�� 
errnW m    �����T��  ��  ��  N X��X P   �YZ[Y k   �\\ ]^] Q   #_`a_ k   �bb cdc r    *efe n   (ghg I   " (��i���� "0 astextparameter asTextParameteri jkj o   " #���� "0 callhandlername callHandlerNamek l��l m   # $mm �nn  i n��  ��  h o    "���� 0 _supportlib _supportLibf o      ���� "0 callhandlername callHandlerNamed opo r   + 8qrq n  + 6sts I   0 6��u���� &0 asrecordparameter asRecordParameteru vwv o   0 1���� 0 expectederror expectedErrorw x��x m   1 2yy �zz  i s��  ��  t o   + 0���� 0 _supportlib _supportLibr o      ���� 0 expectederror expectedErrorp {|{ r   9 E}~} n  9 C� I   > C������� <0 normalizeexpectederrorrecord normalizeExpectedErrorRecord� ���� o   > ?���� 0 expectederror expectedError��  ��  � o   9 >���� 0 _testsupport _TestSupport~ o      ���� 0 expectederror expectedError| ��� l  F F������  � � � TO DO: what about checking expectedError record's properties are valid types (e.g. error number should be integer, message should be text, etc.), and abort with broken test if not   � ���h   T O   D O :   w h a t   a b o u t   c h e c k i n g   e x p e c t e d E r r o r   r e c o r d ' s   p r o p e r t i e s   a r e   v a l i d   t y p e s   ( e . g .   e r r o r   n u m b e r   s h o u l d   b e   i n t e g e r ,   m e s s a g e   s h o u l d   b e   t e x t ,   e t c . ) ,   a n d   a b o r t   w i t h   b r o k e n   t e s t   i f   n o t� ��� r   F S��� n  F Q��� I   K Q������� "0 astextparameter asTextParameter� ��� o   K L���� 0 usernote userNote� ���� m   L M�� ���  s u m m a r y��  ��  � o   F K���� 0 _supportlib _supportLib� o      ���� 0 usernote userNote� ��� l  T T������  � G A code-generate a script object to invoke the `call_NAME` handler�   � ��� �   c o d e - g e n e r a t e   a   s c r i p t   o b j e c t   t o   i n v o k e   t h e   ` c a l l _ N A M E `   h a n d l e r &� ��� P   T ������ Z   Y ������� =  Y \��� o   Y Z���� "0 callhandlername callHandlerName� m   Z [�� ���  � l  _ t���� r   _ t��� b   _ r��� m   _ `�� ���  c a l l� l  ` q������ n   ` q��� 7  e q����
�� 
ctxt� m   i m���� � m   n p������� o   ` e���� $0 _testhandlername _testHandlerName��  ��  � o      ���� "0 callhandlername callHandlerName� | v if `for` parameter is omitted, automatically call a `call_NAME` handler with the same NAME as the `test_NAME` handler   � ��� �   i f   ` f o r `   p a r a m e t e r   i s   o m i t t e d ,   a u t o m a t i c a l l y   c a l l   a   ` c a l l _ N A M E `   h a n d l e r   w i t h   t h e   s a m e   N A M E   a s   t h e   ` t e s t _ N A M E `   h a n d l e r� ��� H   w }�� C   w |��� o   w x���� "0 callhandlername callHandlerName� m   x {�� ��� 
 c a l l _� ���� r   � ���� b   � ���� m   � ��� ��� 
 c a l l _� o   � ����� "0 callhandlername callHandlerName� o      ���� "0 callhandlername callHandlerName��  ��  ��  � ����
�� conscase��  � ��� Z   � ������� =  � ���� o   � �����  0 parametervalue parameterValue� m   � ���
�� 
���!� r   � ���� n  � ���� I   � ��������  0 makecallobject makeCallObject� ��� o   � ����� "0 callhandlername callHandlerName� ���� m   � �����  ��  ��  � o   � ����� 0 _testsupport _TestSupport� o      ���� 0 
callobject 
callObject��  � r   � ���� n  � ���� I   � ��������  0 makecallobject makeCallObject� ��� o   � ����� "0 callhandlername callHandlerName� ���� m   � ����� ��  ��  � o   � ����� 0 _testsupport _TestSupport� o      ���� 0 
callobject 
callObject� ��� l  � �������  �   �then call it   � ���    & t h e n   c a l l   i t� ��� l  � ����� r   � ���� J   � ��� ��� n  � ���� o   � ����� 0 novalue NoValue� o   � ����� 0 _testsupport _TestSupport� ��� n  � ���� o   � ����� 0 novalue NoValue� o   � ����� 0 _testsupport _TestSupport� ���� m   � ���
�� boovfals��  � J      �� ��� o      ���� 0 actualerror actualError� ��� o      ���� 0 actualresult actualResult� ���� o      ���� 0 isequal isEqual��  � \ V TO DO: rename isEqual to isSuccess once 'is equal' test code is moved to Check object   � ��� �   T O   D O :   r e n a m e   i s E q u a l   t o   i s S u c c e s s   o n c e   ' i s   e q u a l '   t e s t   c o d e   i s   m o v e d   t o   C h e c k   o b j e c t� ���� Q   ������ l  � ����� r   � ���� n  � ���� I   � ��� ���� 0 dotest doTest   o   � ����� $0 _testsuiteobject _testSuiteObject �� o   � �����  0 parametervalue parameterValue��  ��  � o   � ����� 0 
callobject 
callObject� o      ���� 0 actualresult actualResult� n h note: this may return literal 'no value' due to AS's schlonky design - this will be accounted for below   � � �   n o t e :   t h i s   m a y   r e t u r n   l i t e r a l   ' n o   v a l u e '   d u e   t o   A S ' s   s c h l o n k y   d e s i g n   -   t h i s   w i l l   b e   a c c o u n t e d   f o r   b e l o w� R      ��
�� .ascrerr ****      � **** o      ���� 0 etext eText ��
�� 
errn o      ���� 0 enumber eNumber ��	

�� 
erob	 o      ���� 0 efrom eFrom
 �
� 
errt o      �~�~ 
0 eto eTo �}�|
�} 
ptlr o      �{�{ 0 epartial ePartial�|  � k   ��  r   � n  � I  �z�y�z .0 makecaughterrorrecord makeCaughtErrorRecord  o  �x�x 0 etext eText  o  �w�w 0 enumber eNumber  o  �v�v 0 efrom eFrom  o  �u�u 
0 eto eTo �t o  �s�s 0 epartial ePartial�t  �y   o   ��r�r 0 _testsupport _TestSupport o      �q�q 0 actualerror actualError   l �p!"�p  !@: compare expected vs actual error info, ignoring any actual error info that user-supplied record doesn't care about; TO DO: shove these tests into a [default] IsEqualErrorCheck object; custom check objects may then be passed via optional parameter to perform other types of tests (e.g. `is in`, `is in range`, etc)   " �##t   c o m p a r e   e x p e c t e d   v s   a c t u a l   e r r o r   i n f o ,   i g n o r i n g   a n y   a c t u a l   e r r o r   i n f o   t h a t   u s e r - s u p p l i e d   r e c o r d   d o e s n ' t   c a r e   a b o u t ;   T O   D O :   s h o v e   t h e s e   t e s t s   i n t o   a   [ d e f a u l t ]   I s E q u a l E r r o r C h e c k   o b j e c t ;   c u s t o m   c h e c k   o b j e c t s   m a y   t h e n   b e   p a s s e d   v i a   o p t i o n a l   p a r a m e t e r   t o   p e r f o r m   o t h e r   t y p e s   o f   t e s t s   ( e . g .   ` i s   i n ` ,   ` i s   i n   r a n g e ` ,   e t c )  $%$ r  &'& m  �o
�o boovtrue' o      �n�n 0 isequal isEqual% ()( Z ;*+�m�l* F  +,-, o  �k�k 0 isequal isEqual- > './. n 010 o  �j�j 0 	errortext 	errorText1 o  �i�i 0 expectederror expectedError/ n &232 o  "&�h�h 0 novalue NoValue3 o  "�g�g 0 _testsupport _TestSupport+ r  .7454 = .5676 n .3898 o  /3�f�f 0 	errortext 	errorText9 o  ./�e�e 0 expectederror expectedError7 o  34�d�d 0 etext eText5 o      �c�c 0 isequal isEqual�m  �l  ) :;: Z <c<=�b�a< F  <S>?> o  <=�`�` 0 isequal isEqual? > @O@A@ n @EBCB o  AE�_�_ 0 errornumber errorNumberC o  @A�^�^ 0 expectederror expectedErrorA n ENDED o  JN�]�] 0 novalue NoValueE o  EJ�\�\ 0 _testsupport _TestSupport= r  V_FGF = V]HIH n V[JKJ o  W[�[�[ 0 errornumber errorNumberK o  VW�Z�Z 0 expectederror expectedErrorI o  [\�Y�Y 0 enumber eNumberG o      �X�X 0 isequal isEqual�b  �a  ; LML Z d�NO�W�VN F  d{PQP o  de�U�U 0 isequal isEqualQ > hwRSR n hmTUT o  im�T�T 0 
errorvalue 
errorValueU o  hi�S�S 0 expectederror expectedErrorS n mvVWV o  rv�R�R 0 novalue NoValueW o  mr�Q�Q 0 _testsupport _TestSupportO r  ~�XYX = ~�Z[Z n ~�\]\ o  ��P�P 0 
errorvalue 
errorValue] o  ~�O�O 0 expectederror expectedError[ o  ���N�N 0 efrom eFromY o      �M�M 0 isequal isEqual�W  �V  M ^_^ Z ��`a�L�K` F  ��bcb o  ���J�J 0 isequal isEqualc > ��ded n ��fgf o  ���I�I 0 expectedtype expectedTypeg o  ���H�H 0 expectederror expectedErrore n ��hih o  ���G�G 0 novalue NoValuei o  ���F�F 0 _testsupport _TestSupporta r  ��jkj = ��lml n ��non o  ���E�E 0 expectedtype expectedTypeo o  ���D�D 0 expectederror expectedErrorm o  ���C�C 
0 eto eTok o      �B�B 0 isequal isEqual�L  �K  _ pqp Z ��rs�A�@r F  ��tut o  ���?�? 0 isequal isEqualu > ��vwv n ��xyx o  ���>�> 0 partialresult partialResulty o  ���=�= 0 expectederror expectedErrorw n ��z{z o  ���<�< 0 novalue NoValue{ o  ���;�; 0 _testsupport _TestSupports r  ��|}| = ��~~ n ����� o  ���:�: 0 partialresult partialResult� o  ���9�9 0 expectederror expectedError o  ���8�8 0 epartial ePartial} o      �7�7 0 isequal isEqual�A  �@  q ��6� l ���5���5  � � � TO DO: what about checking error record's properties are valid types (e.g. error number should be integer, message should be text, etc.), and fail test if not   � ���>   T O   D O :   w h a t   a b o u t   c h e c k i n g   e r r o r   r e c o r d ' s   p r o p e r t i e s   a r e   v a l i d   t y p e s   ( e . g .   e r r o r   n u m b e r   s h o u l d   b e   i n t e g e r ,   m e s s a g e   s h o u l d   b e   t e x t ,   e t c . ) ,   a n d   f a i l   t e s t   i f   n o t�6  ��  ` R      �4��
�4 .ascrerr ****      � ****� o      �3�3 0 etext eText� �2��
�2 
errn� o      �1�1 0 enumber eNumber� �0��
�0 
erob� o      �/�/ 0 efrom eFrom� �.��
�. 
errt� o      �-�- 
0 eto eTo� �,��+
�, 
ptlr� o      �*�* 0 epartial ePartial�+  a k  �#�� ��� n ���� I  ��)��(�) 0 	addbroken 	addBroken� ��� m  ���� ��� " a s s e r t   t e s t   e r r o r� ��� m  ���� ��� < ( e . g .   r e c e i v e d   b a d   p a r a m e t e r s )� ��� o  ���'�' 0 usernote userNote� ��&� l 	���%�$� J  ��� ��#� J  ��� ��� m  ���� ���   u n e x p e c t e d   e r r o r� ��"� n ���� I  ��!�� �! .0 makecaughterrorrecord makeCaughtErrorRecord� ��� o  ���� 0 etext eText� ��� o  ���� 0 enumber eNumber� ��� o  ���� 0 efrom eFrom� ��� o  ���� 
0 eto eTo� ��� o  ���� 0 epartial ePartial�  �   � o  ���� 0 _testsupport _TestSupport�"  �#  �%  �$  �&  �(  � o  ���� 0 _testreport _testReport� ��� R  #���
� .ascrerr ****      � ****�  � ���
� 
errn� o  �� 00 _abortedassertionerror _AbortedAssertionError� ���
� 
erob� o  �� 00 _abortedassertiontoken _AbortedAssertionToken�  �  ^ ��� r  $.��� J  $,�� ��� J  $*�� ��� m  $'�� ���  e x p e c t e d   e r r o r� ��� o  '(�� 0 expectederror expectedError�  �  � o      �� 0 testdata testData� ��� Z  /����
�� o  /0�	�	 0 isequal isEqual� l 3M���� k  3M�� ��� n 3J��� I  8J���� 0 
addsuccess 
addSuccess� ��� m  8;�� ��� " a s s e r t   t e s t   e r r o r� ��� o  ;<�� 0 usernote userNote� ��� b  <F��� o  <=�� 0 testdata testData� J  =E�� ��� J  =C�� ��� m  =@�� ���  a c t u a l   e r r o r� ��� o  @A�� 0 actualerror actualError�  �  �  �  � o  38� �  0 _testreport _testReport� ���� L  KM����  ��  �   success   � ���    s u c c e s s�
  � k  P��� ��� l PP������  � 2 , raised wrong error or didn't raise an error   � ��� X   r a i s e d   w r o n g   e r r o r   o r   d i d n ' t   r a i s e   a n   e r r o r� ��� Q  Pi���� l SV���� l SV���� r  SV��� o  ST���� 0 actualresult actualResult� o      ���� 0 actualresult actualResult� � z this variable lookup fails if call_NAME returned nothing (i.e. `null`, which AS literally treats as 'no value at all')...   � ��� �   t h i s   v a r i a b l e   l o o k u p   f a i l s   i f   c a l l _ N A M E   r e t u r n e d   n o t h i n g   ( i . e .   ` n u l l ` ,   w h i c h   A S   l i t e r a l l y   t r e a t s   a s   ' n o   v a l u e   a t   a l l ' ) . . .� g a kludge-around for AS's dumb commands-are-not-expressions-so-do-not-have-to-return-results design   � ��� �   k l u d g e - a r o u n d   f o r   A S ' s   d u m b   c o m m a n d s - a r e - n o t - e x p r e s s i o n s - s o - d o - n o t - h a v e - t o - r e t u r n - r e s u l t s   d e s i g n� R      �����
�� .ascrerr ****      � ****��  � �����
�� 
errn� d      �� m      ����
���  � l ^i�� � r  ^i n ^g o  cg���� 0 novalue NoValue o  ^c���� 0 _testsupport _TestSupport o      ���� 0 actualresult actualResult� a [ ... in which case replace it with a 'no value placeholder' object that AS can actually see     � �   . . .   i n   w h i c h   c a s e   r e p l a c e   i t   w i t h   a   ' n o   v a l u e   p l a c e h o l d e r '   o b j e c t   t h a t   A S   c a n   a c t u a l l y   s e e�  Z j�	���� > ju

 o  jk���� 0 actualerror actualError n kt o  pt���� 0 novalue NoValue o  kp���� 0 _testsupport _TestSupport	 r  x� J  x�  m  x{ � 0 r e c e i v e d   i n c o r r e c t   e r r o r �� J  {�  m  {~ �  a c t u a l   e r r o r �� o  ~���� 0 actualerror actualError��  ��   J        o      ���� 0 problemtype problemType �� n       !   ;  ��! o  ������ 0 testdata testData��  ��  ��   "#" Z ��$%����$ > ��&'& o  ������ 0 actualresult actualResult' n ��()( o  ������ 0 novalue NoValue) o  ������ 0 _testsupport _TestSupport% r  ��*+* J  ��,, -.- m  ��// �00 " r e c e i v e d   n o   e r r o r. 1��1 J  ��22 343 m  ��55 �66 " u n e x p e c t e d   r e s u l t4 7��7 o  ������ 0 actualresult actualResult��  ��  + J      88 9:9 o      ���� 0 problemtype problemType: ;��; n      <=<  ;  ��= o  ������ 0 testdata testData��  ��  ��  # >?> n ��@A@ I  ����B���� 0 
addfailure 
addFailureB CDC m  ��EE �FF " a s s e r t   t e s t   e r r o rD GHG o  ������ 0 problemtype problemTypeH IJI o  ������ 0 usernote userNoteJ K��K o  ������ 0 testdata testData��  ��  A o  ������ 0 _testreport _testReport? L��L R  ������M
�� .ascrerr ****      � ****��  M ��NO
�� 
errnN o  ������ 00 _abortedassertionerror _AbortedAssertionErrorO ��P��
�� 
erobP o  ������ 00 _abortedassertiontoken _AbortedAssertionToken��  ��  �  Z ��Q
�� conscaseQ ��R
�� consdiacR ��S
�� conshyphS ��T
�� conspuncT ����
�� conswhit��  [ ����
�� consnume��  ��  / UVU l     ��������  ��  ��  V WXW l     ��������  ��  ��  X Y��Y l     ��������  ��  ��  ��       ��Z[\]^_`��a��������bcdefghij��  Z ������������������������������������������
�� 
pimr�� 0 _supportlib _supportLib�� 
0 _error  �� 0 _testsupport _TestSupport�� 0 
randomword 
randomWord
�� .���:MTmrnull��� ��� ctxt�� 00 _abortedassertionerror _AbortedAssertionError�� 00 _abortedassertiontoken _AbortedAssertionToken�� $0 _testsuiteobject _testSuiteObject�� 0 _testreport _testReport�� $0 _testhandlername _testHandlerName�� 0 
_skipsuite 
_SKIPSUITE�� 0 __performunittestforsuite__  
�� .���:ExEqnull��� ��� null
�� .���:NmEqnull��� ��� null�� .0 _defaultequalitycheck _defaultEqualityCheck�� :0 _defaulterrorpropertychecks _defaultErrorPropertyChecks
�� .���:ExErnull��� ��� null�� (0 _defaulterrorcheck _defaultErrorCheck
�� .���:AsRenull��� ��� null
�� .���:AsErnull��� ��� null[ ��k�� k  lml ��n��
�� 
cobjn oo   �� 
�� 
frmk��  m ��p��
�� 
cobjp qq   ��
�� 
osax��  \ rr   �� -
�� 
scpt] �� 5����st���� 
0 _error  �� ��u�� u  ������������ 0 handlername handlerName�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo��  s ������������ 0 handlername handlerName�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTot  E������ �� &0 throwcommanderror throwCommandError�� b  ࠡ����+ ^ vv   �� \
�� 
scpt_ �� r����wx���� 0 
randomword 
randomWord�� ��y�� y  ������ 0 	minlength 	minLength�� 0 	maxlength 	maxLength��  w ��~�}� 0 	minlength 	minLength�~ 0 	maxlength 	maxLength�} 0 s  x  �|�{�z�y�x ��w
�| misccura
�{ 
from
�z 
to  �y 
�x .sysorandnmbr    ��� nmbr
�w 
cobj�� (�E�O � *��� Ukh���.%E�[OY��O�` �v ��u�tz{�s
�v .���:MTmrnull��� ��� ctxt�u {�r�q ��r 0 nametext nameText�q  �t  z �p�o�p 0 nametext nameText�o 0 timerobject TimerObject{ �n �|�n 0 timerobject TimerObject| �m}�l�k~�j
�m .ascrinit****      � ****} k     '��  ���  ���  ���  ���  ���  ���  ��� �� �i�i  �l  �k  ~ 	�h�g�f�e�d�c�b�a�`
�h 
pimr�g 0 
_starttime 
_startTime�f 0 _totalseconds _totalSeconds�e 0 
_isrunning 
_isRunning�d 0 	timername 	timerName�c 0 
starttimer 
startTimer�b 0 	stoptimer 	stopTimer�a 0 elapsedtime elapsedTime�` 0 	totaltime 	totalTime �_�^ ��]�\ ��[�Z�����
�_ 
cobj
�^ 
frmk
�] 
msng�\ 0 
_starttime 
_startTime�[ 0 _totalseconds _totalSeconds�Z 0 
_isrunning 
_isRunning� �Y ��X�W���V�Y 0 	timername 	timerName�X  �W  �  �  �V b   � �U ��T�S���R�U 0 
starttimer 
startTimer�T  �S  �  � �Q�P�O
�Q misccura�P 0 nsdate NSDate�O @0 timeintervalsincereferencedate timeIntervalSinceReferenceDate�R (b   hY hOeEc  O��,j+ Ec  O)� �N ��M�L���K�N 0 	stoptimer 	stopTimer�M  �L  � �J�J 0 elapsedtime elapsedTime� �I�H�G
�I misccura�H 0 nsdate NSDate�G @0 timeintervalsincereferencedate timeIntervalSinceReferenceDate�K 9b   jY hO��,j+ b  E�Ob  �Ec  OfEc  O�� �F�E�D���C�F 0 elapsedtime elapsedTime�E  �D  � �B�B 0 nsdate NSDate� �A�A @0 timeintervalsincereferencedate timeIntervalSinceReferenceDate�C b   �j+  b  Y j� �@�?�>���=�@ 0 	totaltime 	totalTime�?  �>  �  � �<�< 0 elapsedtime elapsedTime�= b   b  *j+  Y b  �j (�*��/lkv��O�Of�OL OL 	OL 
OL OL �s ��K S���Aa �;@  ��; 00 _abortedassertiontoken _AbortedAssertionToken�  ��  
�� 
msng
�� 
msng
�� 
msng�� cb �:��9�8���7�: 0 __performunittestforsuite__  �9 �6��6 �  �5��5 0 suiteobject suiteObject� �4��4 �  �3�2�1�3 0 	suitename 	suiteName�2 0 handlername handlerName�1 0 isstyled isStyled�8  � �0�/�.�-�,�+�*�)�(�'�&�%�0 0 suiteobject suiteObject�/ 0 	suitename 	suiteName�. 0 handlername handlerName�- 0 isstyled isStyled�, 0 skipinfo skipInfo�+ 0 
skipreason 
skipReason�* 0 etext eText�) 0 enumber eNumber�( 0 efrom eFrom�' 
0 eto eTo�& 0 epartial ePartial�% 0 
callobject 
callObject� 6�$�#�"�!�� �����������������L���tx|������
�����	��,09��nrv�$  0 maketestreport makeTestReport�# *0 configure_skiptests configure_skipTests�" 0 
hashandler 
hasHandler�!  � ���
� 
errn��?�  
�  
errn��?
� 
erob
� 
errt
� 
reco
� 
ctxt
� 
msng� � 0 istype isType
� misccura� 0 nsdictionary NSDictionary� 60 dictionarywithdictionary_ dictionaryWithDictionary_� 0 objectforkey_ objectForKey_
� 
****� �� ��
� 
errn� �\��  ��\� 0 
addskipped 
addSkipped� 0 	skipsuite 	skipSuite� 0 etext eText� �����
�� 
errn�� 0 enumber eNumber� �����
�� 
erob�� 0 efrom eFrom� �����
�� 
errt�� 
0 eto eTo� ������
�� 
ptlr�� 0 epartial ePartial��  � � .0 makecaughterrorrecord makeCaughtErrorRecord� � 0 	addbroken 	addBroken�
 "0 configure_setup configure_setUp�	  0 makecallobject makeCallObject� 0 dotest doTest
� 
bool� 0 
addfailure 
addFailure� (0 configure_teardown configure_tearDown�7}b  ���m+  Ec  	Ob  ��,k+ ! �j+ E�O �E�W X  )�������mv��Ob  	O�� �b  ��l+  _�a ,�k+ �k+ a &E�O�� ? 
��&E�W X  )�a ����lv�a �%a %Ob  	��l+ Ob  	Y hY @�� 9 
��&E�W X  )�a �����mv�a Ob  	�k+ Ob  	Y hY hW 9X  b  	a a a a  b  �����a !+ "lvkva #+ $Ob  	Y hO�Ec  O�Ec  
Ob  �a %,k+  O 
�j+ %W AX  b  	a &a 'a (a )b  �����a !+ "lvkva #+ $O�Ec  Ob  	Y hOb  �jl+ *E�O ���l+ +W MX  �b   	 �b   a ,& .b  	�a -a .a /b  �����a !+ "lvkva #+ 0Y hOb  �a 1,k+  @ 
�j+ 1W 2X  b  	a 2a 3a 4a 5b  �����a !+ "lvkva #+ $Y hO�Ec  Ob  	c �����������
�� .���:ExEqnull��� ��� null��  ��  � ���� (0 exactequalitycheck ExactEqualityCheck� ������ (0 exactequalitycheck ExactEqualityCheck� �����������
�� .ascrinit****      � ****� k     �� �����  ��  ��  � ����  0 compareobjects compareObjects� �� �������������  0 compareobjects compareObjects�� ����� �  ������ 0 expectederror expectedError�� 0 actualerror actualError��  � ������ 0 expectederror expectedError�� 0 actualerror actualError� ����
�� 
pcls�� �� ��,��, fY hO�� V�� L  �� ��K S�d �����������
�� .���:NmEqnull��� ��� null��  ��  � ���� 00 numericalequalitycheck NumericalEqualityCheck� ������ 00 numericalequalitycheck NumericalEqualityCheck� �����������
�� .ascrinit****      � ****� k     �� ��� �����  ��  ��  � ������ 0 _isequaldelta _isEqualDelta��  0 compareobjects compareObjects� ������ 0 _isequaldelta _isEqualDelta� �������������  0 compareobjects compareObjects�� ����� �  ������ 0 expectederror expectedError�� 0 actualerror actualError��  � ������ 0 expectederror expectedError�� 0 actualerror actualError� ��������
�� 
kocl
�� 
nmbr
�� .corecnte****       ****
�� 
bool�� /��lv��l l fY hO�b   �	 �b   ��&�� �OL �� ��K S�e ���  ��� (0 exactequalitycheck ExactEqualityCheck� ������  f ��e��� 0 	errortext 	errorText� ��e��� 0 errornumber errorNumber� ��e��� 0 
errorvalue 
errorValue� ��e��� 0 expectedtype expectedType� ��e���� 0 partialresult partialResult��  g ��?��������
�� .���:ExErnull��� ��� null��  �� �����
�� 
Usin� {��������  0 propertychecks propertyChecks��  ��  ��  � ����������������  0 propertychecks propertyChecks�� 0 checkobjects checkObjects�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo�� "0 exacterrorcheck ExactErrorCheck� U������������k���{���������� &0 asrecordparameter asRecordParameter
�� 
leng
�� 
errn���Y
�� 
erob�� �� 0 etext eText� �����
�� 
errn�� 0 enumber eNumber� �����
�� 
erob�� 0 efrom eFrom� ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� "0 exacterrorcheck ExactErrorCheck� �����������
�� .ascrinit****      � ****� k     �� �����  ��  ��  � ����  0 compareobjects compareObjects� �� �������������  0 compareobjects compareObjects�� ����� �  ������ 0 expectederror expectedError�� 0 actualerror actualError��  � �������������� 0 expectederror expectedError�� 0 actualerror actualError�� 0 aref aRef�� $0 expectedproperty expectedProperty��  0 actualproperty actualProperty�� 0 checkobject checkObject� ��������������������~�� 0 errornumber errorNumber�� 0 	errortext 	errorText�� 0 
errorvalue 
errorValue�� 0 expectedtype expectedType�� 0 partialresult partialResult�� 
�� 
kocl
�� 
cobj
�� .corecnte****       ****� 0 novalue NoValue�~  0 compareobjects compareObjects�� � ���,��,b  �,mv��,��,b  �,mv��,��,b  �,mv��,��,b  �,mv��,��,b  �,mv�v[��l kh �E[�k/E�Z[�l/E�Z[�m/E�ZO�b  �, ���l+ 
f  fY hY h[OY��Oe�� L  �� P 7b  ��l+ E�O�b  %E�O��,b  �, )�����Y hW X  	*ꢣ���+ O��K S�h �}�  ��} "0 exacterrorcheck ExactErrorCheck� ���� 	 ��f�|�{�z�yh� �x�w�x  �w  �|  �{  �z  �y  i �v�u�t���s
�v .���:AsRenull��� ��� null�u  �t �r�q�
�r 
Valu�q 0 actualresult actualResult� �p�o�
�p 
Equa�o  0 expectedresult expectedResult� �n��
�n 
Summ� {�m�l&�m 0 usernote userNote�l  � �k��j
�k 
Usin� {�i�h�g�i 0 checkobject checkObject�h  
�g 
msng�j  � �f�e�d�c�b�a�`�_�^�]�\�f 0 actualresult actualResult�e  0 expectedresult expectedResult�d 0 usernote userNote�c 0 checkobject checkObject�b 0 etext eText�a 0 enumber eNumber�` 0 efrom eFrom�_ 
0 eto eTo�^ 0 epartial ePartial�] 0 isequal isEqual�\ 0 testdata testData� "�[�Z�Y5:;M�Xa�W�V�U�T�S�Rp�Q�����P�O�N�����
�M�L
�[ 
msng
�Z 
errn�Y�T�X "0 astextparameter asTextParameter�W &0 asscriptparameter asScriptParameter�V  0 compareobjects compareObjects�U 0 
hashandler 
hasHandler�T�@
�S 
erob�R �Q 0 etext eText� �K�J�
�K 
errn�J 0 enumber eNumber� �I�H�
�I 
erob�H 0 efrom eFrom� �G�F�
�G 
errt�F 
0 eto eTo� �E�D�C
�E 
ptlr�D 0 epartial ePartial�C  �P �O .0 makecaughterrorrecord makeCaughtErrorRecord�N 0 	addbroken 	addBroken�M 0 
addsuccess 
addSuccess�L 0 
addfailure 
addFailure�sCb  �  )��l�Y hO��* Pb  ��l+ E�O��  b  E�Y hOb  ��l+ 	E�Ob  ��,k+  )������Y hW ?X  b  	a a �a b  �����a + lvkv�+ O)�b  �b  �hO ���l+ 
E�W ?X  b  	a a �a b  �����a + lvkv�+ O)�b  �b  �hOa �lva �lvlvE�O� b  	a ��m+ OhY $b  	a a  ���+ !O)�b  �b  �hVj �B1�A�@���?
�B .���:AsErnull��� ��� null�A  �@ �>��
�> 
Hand� {�=�<8�= "0 callhandlername callHandlerName�<  � �;��
�; 
Args� {�:�9�8�:  0 parametervalue parameterValue�9  
�8 
���!� �7�6�
�7 
Equa�6 0 expectederror expectedError� �5��
�5 
Summ� {�4�3F�4 0 usernote userNote�3  � �2��1
�2 
Usin� {�0�/�.�0 0 checkobject checkObject�/  
�. 
msng�1  � �-�,�+�*�)�(�'�&�%�$�#�"�!� ���- "0 callhandlername callHandlerName�,  0 parametervalue parameterValue�+ 0 expectederror expectedError�* 0 usernote userNote�) 0 checkobject checkObject�( 0 
callobject 
callObject�' 0 actualerror actualError�& 0 actualresult actualResult�% 0 isequal isEqual�$ 0 etext eText�# 0 enumber eNumber�" 0 efrom eFrom�! 
0 eto eTo�  0 epartial ePartial� 0 testdata testData� 0 problemtype problemType� 3���UZ[m�y�����������������������
�	������������/5E�
� 
msng
� 
errn��T� "0 astextparameter asTextParameter� &0 asrecordparameter asRecordParameter� <0 normalizeexpectederrorrecord normalizeExpectedErrorRecord
� 
ctxt� 
� 
���!�  0 makecallobject makeCallObject� 0 novalue NoValue
� 
cobj� 0 dotest doTest� 0 etext eText� ���
� 
errn� 0 enumber eNumber� � ���
�  
erob�� 0 efrom eFrom� �����
�� 
errt�� 
0 eto eTo� ������
�� 
ptlr�� 0 epartial ePartial��  � .0 makecaughterrorrecord makeCaughtErrorRecord� 0 	errortext 	errorText
� 
bool� 0 errornumber errorNumber� 0 
errorvalue 
errorValue�
 0 expectedtype expectedType�	 0 partialresult partialResult� � 0 	addbroken 	addBroken
� 
erob� 0 
addsuccess 
addSuccess�  � ������
�� 
errn���?��  � 0 
addfailure 
addFailure�?�b  �  )��l�Y hO����b  ��l+ E�Ob  ��l+ 	E�Ob  �k+ 
E�Ob  ��l+ E�Og� 5��  �b  
[�\[Za \Zi2%E�Y �a  a �%E�Y hVO�a   b  �jl+ E�Y b  �kl+ E�Ob  a ,b  a ,fmvE[a k/E�Z[a l/E�Z[a m/E�ZO �b  �l+ E�W �X  b  �����a + E�OeE�O�	 �a ,b  a ,a & �a ,� E�Y hO�	 �a ,b  a ,a & �a ,� E�Y hO�	 �a ,b  a ,a & �a ,� E�Y hO�	 �a ,b  a ,a & �a ,� E�Y hO�	 �a  ,b  a ,a & �a  ,� E�Y hOPW EX  b  	a !a "�a #b  �����a + lvkva $+ %O)�b  a &b  a $hOa '�lvkvE�O� b  	a (��a )�lvkv%m+ *OhY � �E�W X + ,b  a ,E�O�b  a , $a -a .�lvlvE[a k/E�Z[a l/�6FZY hO�b  a , $a /a 0�lvlvE[a k/E�Z[a l/�6FZY hOb  	a 1���a $+ 2O)�b  a &b  a $hVascr  ��ޭ