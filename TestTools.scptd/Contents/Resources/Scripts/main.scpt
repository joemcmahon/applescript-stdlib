FasdUAS 1.101.10   ��   ��    k             l      ��  ��   �� TestTools -- unit testing framework and other testing/profiling tools

About:

- TestTools's unit testing framework takes a NAME.unittest.scpt file containing one or more script objects, each representing a test suite, and each of those script objects containing one or more handlers representing individual unit tests. Test suite scripts must have `suite_` name prefixes; test handlers within those scripts must have `test_` name prefixes.

- The command line `osatest` test runner introspects the unittest script to obtain all suite and test names. For each found test it creates a new AppleScript component instance (interpreter), loads a clean copy of the unittest script into it, then calls [indirectly] TestTools's `__performunittestforsuite__` handler to run that test. The resulting `TestReport` object is then returned to `osatest` to finish generating the report for that test and print it.

Notes:

- Saving unittest scripts as compiled `.scpt` files rather than `.applescript` snippets avoids any risk of test scripts not compiling correctly when run by `osatest` - i.e. it's one less thing to go wrong.

- The `.unittest.scpt[d]` suffix is a convention, not a requirement, but is strongly encouraged. e.g. Future improvements to `osatest` may include the ability to search a library script bundle for any embedded unittest files and run them all automatically.


TO DO:

- implement line-wrapping in TestSupport.scpt to improve readability when displaying reports in Terminal

- embed `osatest` executable in library bundle? or is it best to keep it separate?

- options for automatically spiking TIDs and considering/ignoring options before calling `test_NAME` handler; also, what about an option for composing/decomposing unicode (assuming that's an issue in AS/Cocoa, e.g. when comparing/sorting AS/NS strings); note that localization is harder to spike, but should be done if possible as it affects date and number coercions

- what other check objects should be defined as standard? e.g. `exact range check`, `numeric range check`, `exact containment check`, `exact type check` (checks only that the expected and actual values are of the same type; relatively weak, but still potentially of some use when checking, say, e.g. that actual errorNumber is `integer` and actual errorMessage is `text`), `ASObjC equality check`(checks both values are ocid specifiers then compares them using `-isEqual:`), `text pattern check` (allow wildcard/regexp checking, possibly applying additional check objects to wildcard-matched ranges; this could be useful e.g. when checking error messages where some parts of the message may vary - e.g. disk and home folder names in file paths - so should be either ignored or custom-checked but the rest of the message is constant); also, how might multiple checks be usefully composed? (e.g. currently the `exact error check` constructor optionally accepts an record of one or more equality checkers for customizing how specific error attributes are checked)

      � 	 	~   T e s t T o o l s   - -   u n i t   t e s t i n g   f r a m e w o r k   a n d   o t h e r   t e s t i n g / p r o f i l i n g   t o o l s 
 
 A b o u t : 
 
 -   T e s t T o o l s ' s   u n i t   t e s t i n g   f r a m e w o r k   t a k e s   a   N A M E . u n i t t e s t . s c p t   f i l e   c o n t a i n i n g   o n e   o r   m o r e   s c r i p t   o b j e c t s ,   e a c h   r e p r e s e n t i n g   a   t e s t   s u i t e ,   a n d   e a c h   o f   t h o s e   s c r i p t   o b j e c t s   c o n t a i n i n g   o n e   o r   m o r e   h a n d l e r s   r e p r e s e n t i n g   i n d i v i d u a l   u n i t   t e s t s .   T e s t   s u i t e   s c r i p t s   m u s t   h a v e   ` s u i t e _ `   n a m e   p r e f i x e s ;   t e s t   h a n d l e r s   w i t h i n   t h o s e   s c r i p t s   m u s t   h a v e   ` t e s t _ `   n a m e   p r e f i x e s . 
 
 -   T h e   c o m m a n d   l i n e   ` o s a t e s t `   t e s t   r u n n e r   i n t r o s p e c t s   t h e   u n i t t e s t   s c r i p t   t o   o b t a i n   a l l   s u i t e   a n d   t e s t   n a m e s .   F o r   e a c h   f o u n d   t e s t   i t   c r e a t e s   a   n e w   A p p l e S c r i p t   c o m p o n e n t   i n s t a n c e   ( i n t e r p r e t e r ) ,   l o a d s   a   c l e a n   c o p y   o f   t h e   u n i t t e s t   s c r i p t   i n t o   i t ,   t h e n   c a l l s   [ i n d i r e c t l y ]   T e s t T o o l s ' s   ` _ _ p e r f o r m u n i t t e s t f o r s u i t e _ _ `   h a n d l e r   t o   r u n   t h a t   t e s t .   T h e   r e s u l t i n g   ` T e s t R e p o r t `   o b j e c t   i s   t h e n   r e t u r n e d   t o   ` o s a t e s t `   t o   f i n i s h   g e n e r a t i n g   t h e   r e p o r t   f o r   t h a t   t e s t   a n d   p r i n t   i t . 
 
 N o t e s : 
 
 -   S a v i n g   u n i t t e s t   s c r i p t s   a s   c o m p i l e d   ` . s c p t `   f i l e s   r a t h e r   t h a n   ` . a p p l e s c r i p t `   s n i p p e t s   a v o i d s   a n y   r i s k   o f   t e s t   s c r i p t s   n o t   c o m p i l i n g   c o r r e c t l y   w h e n   r u n   b y   ` o s a t e s t `   -   i . e .   i t ' s   o n e   l e s s   t h i n g   t o   g o   w r o n g . 
 
 -   T h e   ` . u n i t t e s t . s c p t [ d ] `   s u f f i x   i s   a   c o n v e n t i o n ,   n o t   a   r e q u i r e m e n t ,   b u t   i s   s t r o n g l y   e n c o u r a g e d .   e . g .   F u t u r e   i m p r o v e m e n t s   t o   ` o s a t e s t `   m a y   i n c l u d e   t h e   a b i l i t y   t o   s e a r c h   a   l i b r a r y   s c r i p t   b u n d l e   f o r   a n y   e m b e d d e d   u n i t t e s t   f i l e s   a n d   r u n   t h e m   a l l   a u t o m a t i c a l l y . 
 
 
 T O   D O : 
 
 -   i m p l e m e n t   l i n e - w r a p p i n g   i n   T e s t S u p p o r t . s c p t   t o   i m p r o v e   r e a d a b i l i t y   w h e n   d i s p l a y i n g   r e p o r t s   i n   T e r m i n a l 
 
 -   e m b e d   ` o s a t e s t `   e x e c u t a b l e   i n   l i b r a r y   b u n d l e ?   o r   i s   i t   b e s t   t o   k e e p   i t   s e p a r a t e ? 
 
 -   o p t i o n s   f o r   a u t o m a t i c a l l y   s p i k i n g   T I D s   a n d   c o n s i d e r i n g / i g n o r i n g   o p t i o n s   b e f o r e   c a l l i n g   ` t e s t _ N A M E `   h a n d l e r ;   a l s o ,   w h a t   a b o u t   a n   o p t i o n   f o r   c o m p o s i n g / d e c o m p o s i n g   u n i c o d e   ( a s s u m i n g   t h a t ' s   a n   i s s u e   i n   A S / C o c o a ,   e . g .   w h e n   c o m p a r i n g / s o r t i n g   A S / N S   s t r i n g s ) ;   n o t e   t h a t   l o c a l i z a t i o n   i s   h a r d e r   t o   s p i k e ,   b u t   s h o u l d   b e   d o n e   i f   p o s s i b l e   a s   i t   a f f e c t s   d a t e   a n d   n u m b e r   c o e r c i o n s 
 
 -   w h a t   o t h e r   c h e c k   o b j e c t s   s h o u l d   b e   d e f i n e d   a s   s t a n d a r d ?   e . g .   ` e x a c t   r a n g e   c h e c k ` ,   ` n u m e r i c   r a n g e   c h e c k ` ,   ` e x a c t   c o n t a i n m e n t   c h e c k ` ,   ` e x a c t   t y p e   c h e c k `   ( c h e c k s   o n l y   t h a t   t h e   e x p e c t e d   a n d   a c t u a l   v a l u e s   a r e   o f   t h e   s a m e   t y p e ;   r e l a t i v e l y   w e a k ,   b u t   s t i l l   p o t e n t i a l l y   o f   s o m e   u s e   w h e n   c h e c k i n g ,   s a y ,   e . g .   t h a t   a c t u a l   e r r o r N u m b e r   i s   ` i n t e g e r `   a n d   a c t u a l   e r r o r M e s s a g e   i s   ` t e x t ` ) ,   ` A S O b j C   e q u a l i t y   c h e c k ` ( c h e c k s   b o t h   v a l u e s   a r e   o c i d   s p e c i f i e r s   t h e n   c o m p a r e s   t h e m   u s i n g   ` - i s E q u a l : ` ) ,   ` t e x t   p a t t e r n   c h e c k `   ( a l l o w   w i l d c a r d / r e g e x p   c h e c k i n g ,   p o s s i b l y   a p p l y i n g   a d d i t i o n a l   c h e c k   o b j e c t s   t o   w i l d c a r d - m a t c h e d   r a n g e s ;   t h i s   c o u l d   b e   u s e f u l   e . g .   w h e n   c h e c k i n g   e r r o r   m e s s a g e s   w h e r e   s o m e   p a r t s   o f   t h e   m e s s a g e   m a y   v a r y   -   e . g .   d i s k   a n d   h o m e   f o l d e r   n a m e s   i n   f i l e   p a t h s   -   s o   s h o u l d   b e   e i t h e r   i g n o r e d   o r   c u s t o m - c h e c k e d   b u t   t h e   r e s t   o f   t h e   m e s s a g e   i s   c o n s t a n t ) ;   a l s o ,   h o w   m i g h t   m u l t i p l e   c h e c k s   b e   u s e f u l l y   c o m p o s e d ?   ( e . g .   c u r r e n t l y   t h e   ` e x a c t   e r r o r   c h e c k `   c o n s t r u c t o r   o p t i o n a l l y   a c c e p t s   a n   r e c o r d   o f   o n e   o r   m o r e   e q u a l i t y   c h e c k e r s   f o r   c u s t o m i z i n g   h o w   s p e c i f i c   e r r o r   a t t r i b u t e s   a r e   c h e c k e d ) 
 
     
  
 l     ��������  ��  ��        x     �� ����    4    �� 
�� 
frmk  m       �    F o u n d a t i o n��        l     ��������  ��  ��        x    �� ����    2   ��
�� 
osax��        l     ��������  ��  ��        l     ��  ��    J D--------------------------------------------------------------------     �   � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -      l     ��   !��       support    ! � " "    s u p p o r t   # $ # l     ��������  ��  ��   $  % & % l      ' ( ) ' j    �� *�� 0 _support   * N     + + 4    �� ,
�� 
scpt , m     - - � . .  T y p e S u p p o r t ( "  used for parameter checking    ) � / / 8   u s e d   f o r   p a r a m e t e r   c h e c k i n g &  0 1 0 l     ��������  ��  ��   1  2 3 2 i   ! 4 5 4 I      �� 6���� 
0 _error   6  7 8 7 o      ���� 0 handlername handlerName 8  9 : 9 o      ���� 0 etext eText :  ; < ; o      ���� 0 enumber eNumber <  = > = o      ���� 0 efrom eFrom >  ?�� ? o      ���� 
0 eto eTo��  ��   5 n     @ A @ I    �� B���� &0 throwcommanderror throwCommandError B  C D C m     E E � F F  T e s t T o o l s D  G H G o    ���� 0 handlername handlerName H  I J I o    ���� 0 etext eText J  K L K o    	���� 0 enumber eNumber L  M N M o   	 
���� 0 efrom eFrom N  O�� O o   
 ���� 
0 eto eTo��  ��   A o     ���� 0 _support   3  P Q P l     ��������  ��  ��   Q  R S R l     ��������  ��  ��   S  T U T l      V W X V j   " (�� Y�� 0 _testsupport _TestSupport Y N   " ' Z Z 4   " &�� [
�� 
scpt [ m   $ % \ \ � ] ]  T e s t S u p p o r t W . ( sub-library embedded in TestTools.scptd    X � ^ ^ P   s u b - l i b r a r y   e m b e d d e d   i n   T e s t T o o l s . s c p t d U  _ ` _ l     ��������  ��  ��   `  a b a l     ��������  ��  ��   b  c d c l     �� e f��   e J D--------------------------------------------------------------------    f � g g � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - d  h i h l     �� j k��   j   Test Utilities    k � l l    T e s t   U t i l i t i e s i  m n m l     ��������  ��  ��   n  o p o i  ) , q r q I      �� s���� 0 
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
_isRunning L    !! [    "#" o    �D�D 0 _totalseconds _totalSeconds# I    �C�B�A�C 0 elapsedtime elapsedTime�B  �A  �F    L    $$ o    �@�@ 0 _totalseconds _totalSeconds�J   � %&% l     �?�>�=�?  �>  �=  & '(' l     �<�;�:�<  �;  �:  ( )*) l     �9+,�9  + J D--------------------------------------------------------------------   , �-- � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -* ./. l     �801�8  0   Unit Test Framework   1 �22 (   U n i t   T e s t   F r a m e w o r k/ 343 l     �7�6�5�7  �6  �5  4 565 l     7897 j   1 3�4:�4 00 _abortedassertionerror _AbortedAssertionError: m   1 2�3�3A8 P J raised by `assert�` handlers upon failed assertion to terminate that test   9 �;; �   r a i s e d   b y   ` a s s e r t & `   h a n d l e r s   u p o n   f a i l e d   a s s e r t i o n   t o   t e r m i n a t e   t h a t   t e s t6 <=< l     �2�1�0�2  �1  �0  = >?> h   4 ;�/@�/ 00 _abortedassertiontoken _AbortedAssertionToken@ l     �.AB�.  A.( when raising error number AbortedAssertionError, the `from` parameter should carry this unique identifier to confirm error was raised by TestTools, and isn't merely an error in the test code/code being tested that happens to use the same error number (in which case it should be treated as such)   B �CCP   w h e n   r a i s i n g   e r r o r   n u m b e r   A b o r t e d A s s e r t i o n E r r o r ,   t h e   ` f r o m `   p a r a m e t e r   s h o u l d   c a r r y   t h i s   u n i q u e   i d e n t i f i e r   t o   c o n f i r m   e r r o r   w a s   r a i s e d   b y   T e s t T o o l s ,   a n d   i s n ' t   m e r e l y   a n   e r r o r   i n   t h e   t e s t   c o d e / c o d e   b e i n g   t e s t e d   t h a t   h a p p e n s   t o   u s e   t h e   s a m e   e r r o r   n u m b e r   ( i n   w h i c h   c a s e   i t   s h o u l d   b e   t r e a t e d   a s   s u c h )? DED l     �-�,�+�-  �,  �+  E FGF l     �*�)�(�*  �)  �(  G HIH l     �'JK�'  J L F the following are set/unset by __performunittestforsuite__ as it runs   K �LL �   t h e   f o l l o w i n g   a r e   s e t / u n s e t   b y   _ _ p e r f o r m u n i t t e s t f o r s u i t e _ _   a s   i t   r u n sI MNM l     �&�%�$�&  �%  �$  N OPO l     QRSQ j   < @�#T�# $0 _testsuiteobject _testSuiteObjectT m   < ?�"
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
hasHandler� ���� N    �� n    ��� o    ���� *0 configure_skiptests configure_skipTests� o    ���� 0 suiteobject suiteObject��  ��  � o    ���� 0 _support  � Q   #?���� k   &�� ��� r   & -��� n  & +��� I   ' +�������� *0 configure_skiptests configure_skipTests��  ��  � o   & '���� 0 suiteobject suiteObject� o      ���� 0 skipinfo skipInfo� ��� Q   . Q���� l  1 4���� r   1 4��� o   1 2���� 0 skipinfo skipInfo� o      ���� 0 skipinfo skipInfo� > 8 make sure configure_skipTests actually returned a value   � ��� p   m a k e   s u r e   c o n f i g u r e _ s k i p T e s t s   a c t u a l l y   r e t u r n e d   a   v a l u e� R      �����
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
0 eto eTo� ��b� o  '(�a�a 0 epartial ePartial�b  �g  � o  #�`�` 0 _testsupport _TestSupport�i  �j  �l  �k  �m  �n  p o  �_�_ 0 _testreport _testReportn ��^� L  9?�� o  9>�]�] 0 _testreport _testReport�^  ��  ��  � ��� l DD�\���\  �   pre-test preparation   � ��� *   p r e - t e s t   p r e p a r a t i o n� ��� r  DK��� o  DE�[�[ 0 suiteobject suiteObject� o      �Z�Z $0 _testsuiteobject _testSuiteObject� ��� r  LS��� o  LM�Y�Y 0 handlername handlerName� o      �X�X $0 _testhandlername _testHandlerName� ��� l TT�W���W  �)# note: while `osatest` could supply a list of found handler names to check for existence of `configure_setUp` and `configure_tearDown`, that would only work for configure_setUp/configure_tearDown handlers defined directly within the suite script, not configure_setUp/configure_tearDown handlers inherited from a parent script; thus it's necessary to resort here to some undocumented hackery to determine existence of callable configure_setUp/configure_tearDown handlers before trying to call them (see also comments on `hasHandler` in TypeSupport)   � ���F   n o t e :   w h i l e   ` o s a t e s t `   c o u l d   s u p p l y   a   l i s t   o f   f o u n d   h a n d l e r   n a m e s   t o   c h e c k   f o r   e x i s t e n c e   o f   ` c o n f i g u r e _ s e t U p `   a n d   ` c o n f i g u r e _ t e a r D o w n ` ,   t h a t   w o u l d   o n l y   w o r k   f o r   c o n f i g u r e _ s e t U p / c o n f i g u r e _ t e a r D o w n   h a n d l e r s   d e f i n e d   d i r e c t l y   w i t h i n   t h e   s u i t e   s c r i p t ,   n o t   c o n f i g u r e _ s e t U p / c o n f i g u r e _ t e a r D o w n   h a n d l e r s   i n h e r i t e d   f r o m   a   p a r e n t   s c r i p t ;   t h u s   i t ' s   n e c e s s a r y   t o   r e s o r t   h e r e   t o   s o m e   u n d o c u m e n t e d   h a c k e r y   t o   d e t e r m i n e   e x i s t e n c e   o f   c a l l a b l e   c o n f i g u r e _ s e t U p / c o n f i g u r e _ t e a r D o w n   h a n d l e r s   b e f o r e   t r y i n g   t o   c a l l   t h e m   ( s e e   a l s o   c o m m e n t s   o n   ` h a s H a n d l e r `   i n   T y p e S u p p o r t )� ��� Z  T����V�U� n Tc��� I  Yc�T��S�T 0 
hashandler 
hasHandler� ��R� N  Y_�� n  Y^��� o  Z^�Q�Q "0 configure_setup configure_setUp� o  YZ�P�P 0 suiteobject suiteObject�R  �S  � o  TY�O�O 0 _support  � Q  f����� n in��� I  jn�N�M�L�N "0 configure_setup configure_setUp�M  �L  � o  ij�K�K 0 suiteobject suiteObject� R      �J��
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
0 eto eToF G��G o  ���� 0 epartial ePartial��  �   = o  ����� 0 _testsupport _TestSupport�  �  �  �  �  �  & o  ������ 0 _testreport _testReport#�� TO DO: without stack trace support, there's no way to distinguish an error raised by the code being tested versus an error caused by a bug in the test code, so we can only say error was 'unexpected' and leave user to figure out why; allowing `call_NAME` handlers to be used by `assert test result` would give users the opportunity to box up the code being tested allowing TestTools to distinguish the cause   $ �HH.   T O   D O :   w i t h o u t   s t a c k   t r a c e   s u p p o r t ,   t h e r e ' s   n o   w a y   t o   d i s t i n g u i s h   a n   e r r o r   r a i s e d   b y   t h e   c o d e   b e i n g   t e s t e d   v e r s u s   a n   e r r o r   c a u s e d   b y   a   b u g   i n   t h e   t e s t   c o d e ,   s o   w e   c a n   o n l y   s a y   e r r o r   w a s   ' u n e x p e c t e d '   a n d   l e a v e   u s e r   t o   f i g u r e   o u t   w h y ;   a l l o w i n g   ` c a l l _ N A M E `   h a n d l e r s   t o   b e   u s e d   b y   ` a s s e r t   t e s t   r e s u l t `   w o u l d   g i v e   u s e r s   t h e   o p p o r t u n i t y   t o   b o x   u p   t h e   c o d e   b e i n g   t e s t e d   a l l o w i n g   T e s t T o o l s   t o   d i s t i n g u i s h   t h e   c a u s e  � � check if failure was already reported, and this is the subsequent abort, in which case ignore; if not, it's an error in either the test_NAME handler or the code being tested, so report it   ! �IIx   c h e c k   i f   f a i l u r e   w a s   a l r e a d y   r e p o r t e d ,   a n d   t h i s   i s   t h e   s u b s e q u e n t   a b o r t ,   i n   w h i c h   c a s e   i g n o r e ;   i f   n o t ,   i t ' s   a n   e r r o r   i n   e i t h e r   t h e   t e s t _ N A M E   h a n d l e r   o r   t h e   c o d e   b e i n g   t e s t e d ,   s o   r e p o r t   i t�  �     test failed    �JJ    t e s t   f a i l e d� KLK l ��MN��  M   post-test clean up   N �OO &   p o s t - t e s t   c l e a n   u pL PQP Z  mRS����R n +TUT I  !+��V���� 0 
hashandler 
hasHandlerV W��W N  !'XX n  !&YZY o  "&���� (0 configure_teardown configure_tearDownZ o  !"���� 0 suiteobject suiteObject��  ��  U o  !���� 0 _support  S Q  .i[\][ n 16^_^ I  26�������� (0 configure_teardown configure_tearDown��  ��  _ o  12���� 0 suiteobject suiteObject\ R      ��`a
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
�� .���:ExEqnull��� ��� null��  ��  � h     ����� (0 exactequalitycheck ExactEqualityCheck� i    ��� I      �������  0 compareobjects compareObjects� ��� o      ���� 0 expectedvalue expectedValue� ���� o      ���� 0 actualvalue actualValue��  ��  � P     ���� k    �� ��� l   ������  � l f also check types are identical, e.g. if unittest indicates a real is expected then integer is a smell   � ��� �   a l s o   c h e c k   t y p e s   a r e   i d e n t i c a l ,   e . g .   i f   u n i t t e s t   i n d i c a t e s   a   r e a l   i s   e x p e c t e d   t h e n   i n t e g e r   i s   a   s m e l l� ��� Z   ������� >   ��� n    ��� m    ��
�� 
pcls� o    ���� 0 expectedvalue expectedValue� n    ��� m   	 ��
�� 
pcls� o    	���� 0 actualvalue actualValue� L    �� m    ��
�� boovfals��  ��  � ���� L    �� =   ��� o    ���� 0 expectedvalue expectedValue� o    ���� 0 actualvalue actualValue��  � ���
�� conscase� ���
�� consdiac� ���
�� conshyph� ���
�� conspunc� ����
�� conswhit��  � ����
�� consnume��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  X [��� I     �����
�� .���:NmEqnull��� ��� null��  � �����
�� 
ETyp� |����������  ��  � o      ���� (0 issametyperequired isSameTypeRequired��  � l     ������ m      ��
�� boovtrue��  ��  ��  � l    4���� Q     4���� k    "�� ��� Z    ������ n   ��� I    ������� (0 asbooleanparameter asBooleanParameter� ��� o    	���� (0 issametyperequired isSameTypeRequired� ���� m   	 
�� ���  m a t c h i n g   t y p e s��  ��  � o    ���� 0 _support  � r    ��� m    ��
�� 
doub� o      ���� 0 	checktype 	checkType��  � r    ��� m    ��
�� 
nmbr� o      ���� 0 	checktype 	checkType� ���� h    "����� 00 numericalequalitycheck NumericalEqualityCheck� k      �� ��� j     �� �� 0 _isequaldelta _isEqualDelta  m      =q���-�� �� i    I      �����  0 compareobjects compareObjects  o      �~�~ 0 expectedvalue expectedValue �} o      �|�| 0 actualvalue actualValue�}  �   k     �		 

 Z    �{�z =      l    
�y�x I    
�w
�w .corecnte****       **** J       o     �v�v 0 expectedvalue expectedValue �u o    �t�t 0 actualvalue actualValue�u   �s�r
�s 
kocl m    �q
�q 
long�r  �y  �x   m   
 �p�p  L     =     o    �o�o 0 expectedvalue expectedValue o    �n�n 0 actualvalue actualValue�{  �z    Z   1�m�l >    (  l   &!�k�j! I   &�i"#
�i .corecnte****       ****" J    $$ %&% o    �h�h 0 expectedvalue expectedValue& '�g' o    �f�f 0 actualvalue actualValue�g  # �e(�d
�e 
kocl( o    "�c�c 0 	checktype 	checkType�d  �k  �j    m   & '�b�b  L   + -)) m   + ,�a
�a boovfals�m  �l   *+* r   2 I,-, J   2 :.. /0/ c   2 5121 o   2 3�`�` 0 expectedvalue expectedValue2 m   3 4�_
�_ 
doub0 3�^3 c   5 8454 o   5 6�]�] 0 actualvalue actualValue5 m   6 7�\
�\ 
doub�^  - J      66 787 o      �[�[ 0 n1  8 9�Z9 o      �Y�Y 0 n2  �Z  + :;: Z   J e<=�X>< =   J M?@? o   J K�W�W 0 n1  @ m   K L�V�V  = r   P YABA ]   P WCDC o   P U�U�U 0 _isequaldelta _isEqualDeltaD o   U V�T�T 0 n2  B o      �S�S 0 d1  �X  > r   \ eEFE ]   \ cGHG o   \ a�R�R 0 _isequaldelta _isEqualDeltaH o   a b�Q�Q 0 n1  F o      �P�P 0 d1  ; IJI r   f jKLK d   f hMM o   f g�O�O 0 d1  L o      �N�N 0 d2  J NON Z  k �PQ�M�LP ?   k nRSR o   k l�K�K 0 d1  S o   l m�J�J 0 d2  Q r   q �TUT J   q uVV WXW o   q r�I�I 0 d2  X Y�HY o   r s�G�G 0 d1  �H  U J      ZZ [\[ o      �F�F 0 d1  \ ]�E] o      �D�D 0 d2  �E  �M  �L  O ^_^ r   � �`a` \   � �bcb o   � ��C�C 0 n2  c o   � ��B�B 0 n1  a o      �A�A 0 d  _ d�@d L   � �ee F   � �fgf A   � �hih o   � ��?�? 0 d1  i o   � ��>�> 0 d  g A   � �jkj o   � ��=�= 0 d  k o   � ��<�< 0 d2  �@  ��  ��  � R      �;lm
�; .ascrerr ****      � ****l o      �:�: 0 etext eTextm �9no
�9 
errnn o      �8�8 0 enumber eNumbero �7pq
�7 
erobp o      �6�6 0 efrom eFromq �5r�4
�5 
errtr o      �3�3 
0 eto eTo�4  � I   * 4�2s�1�2 
0 _error  s tut m   + ,vv �ww , n u m e r i c   e q u a l i t y   c h e c ku xyx o   , -�0�0 0 etext eTexty z{z o   - .�/�/ 0 enumber eNumber{ |}| o   . /�.�. 0 efrom eFrom} ~�-~ o   / 0�,�, 
0 eto eTo�-  �1  � � � ignores slight differences due to floating point's limited precision when comparing real numbers -- TO DO: allow magnitude to be optionally specified?   � �.   i g n o r e s   s l i g h t   d i f f e r e n c e s   d u e   t o   f l o a t i n g   p o i n t ' s   l i m i t e d   p r e c i s i o n   w h e n   c o m p a r i n g   r e a l   n u m b e r s   - -   T O   D O :   a l l o w   m a g n i t u d e   t o   b e   o p t i o n a l l y   s p e c i f i e d ?� ��� l     �+�*�)�+  �*  �)  � ��� l     �(�'�&�(  �'  �&  � ��� i  \ _��� I     �%�$�
�% .���:NmRgnull��� ��� null�$  � �#��"
�# 
ETyp� |�!� ����!  �   � o      �� (0 issametyperequired isSameTypeRequired�  � l     ���� m      �
� boovtrue�  �  �"  � Q     *���� k    �� ��� r    ��� n   ��� I    ���� (0 asbooleanparameter asBooleanParameter� ��� o    	�� (0 issametyperequired isSameTypeRequired� ��� m   	 
�� ���  m a t c h i n g   t y p e s�  �  � o    �� 0 _support  � o      �� (0 issametyperequired isSameTypeRequired� ��� h    ��� *0 numericalrangecheck NumericalRangeCheck� i    ��� I      ����  0 compareobjects compareObjects� ��� o      �� 0 expectedvalue expectedValue� ��� o      �� 0 actualvalue actualValue�  �  � k     ��� ��� Z    6����� G     '��� G     ��� =     ��� l    	���
� I    	�	��
�	 .corecnte****       ****� J     �� ��� o     �� 0 expectedvalue expectedValue�  � ���
� 
kocl� m    �
� 
list�  �  �
  � m   	 
��  � >    ��� l   ���� I   � ��
�  .corecnte****       ****� o    ���� 0 expectedvalue expectedValue� �����
�� 
kocl� m    ��
�� 
nmbr��  �  �  � m    ���� � l   %������ ?    %��� n    ��� 4     ���
�� 
cobj� m    ���� � o    ���� 0 expectedvalue expectedValue� n    $��� 4   ! $���
�� 
cobj� m   " #���� � o     !���� 0 expectedvalue expectedValue��  ��  � R   * 2����
�� .ascrerr ****      � ****� m   0 1�� ��� � I n v a l i d   e x p e c t e d   v a l u e   ( n u m e r i c   e q u a l i t y   c h e c k   r e q u i r e s   t w o - i t e m   l i s t   o f   m i n i m u m   a n d   m a x i m u m   n u m b e r s ) .� ����
�� 
errn� m   , -�����Y� �����
�� 
erob� o   . /���� 0 expectedvalue expectedValue��  �  �  � ��� r   7 G��� o   7 8���� 0 expectedvalue expectedValue� J      �� ��� o      ���� "0 expectedminimum expectedMinimum� ���� o      ���� "0 expectedmaximum expectedMaximum��  � ��� Z   H r������ o   H M���� (0 issametyperequired isSameTypeRequired� k   P l�� ��� Z  P f������� >  P W��� n  P S��� m   Q S��
�� 
pcls� o   P Q���� "0 expectedminimum expectedMinimum� n  S V��� m   T V��
�� 
pcls� o   S T���� "0 expectedmaximum expectedMaximum� R   Z b����
�� .ascrerr ****      � ****� m   ` a�� ��� � I n v a l i d   e x p e c t e d   v a l u e   ( n u m e r i c   e q u a l i t y   c h e c k  s    m a t c h i n g   t y p e s    p a r a m e t e r   r e q u i r e s   b o t h   n u m b e r s   t o   b e   s a m e   t y p e ) .� ����
�� 
errn� m   \ ]�����Y� �����
�� 
erob� o   ^ _���� 0 expectedvalue expectedValue��  ��  ��  � ���� r   g l��� n  g j��� m   h j��
�� 
pcls� o   g h���� "0 expectedminimum expectedMinimum� o      ���� 0 	checktype 	checkType��  ��  � r   o r��� m   o p��
�� 
nmbr� o      ���� 0 	checktype 	checkType� ��� Z  s �������� =   s ~��� l  s |������ I  s |����
�� .corecnte****       ****� J   s v�� ���� o   s t���� 0 actualvalue actualValue��  � �����
�� 
kocl� o   w x���� 0 	checktype 	checkType��  ��  ��  � m   | }����  � L   � ��� m   � ���
�� boovfals��  ��  � ���� L   � �   F   � � B   � � o   � ����� "0 expectedminimum expectedMinimum o   � ����� 0 actualvalue actualValue B   � � o   � ����� 0 actualvalue actualValue o   � ����� "0 expectedmaximum expectedMaximum��  �  � R      ��
�� .ascrerr ****      � **** o      ���� 0 etext eText ��	

�� 
errn	 o      ���� 0 enumber eNumber
 ��
�� 
erob o      ���� 0 efrom eFrom ����
�� 
errt o      ���� 
0 eto eTo��  � I     *������ 
0 _error    m   ! " � & n u m e r i c   r a n g e   c h e c k  o   " #���� 0 etext eText  o   # $���� 0 enumber eNumber  o   $ %���� 0 efrom eFrom �� o   % &���� 
0 eto eTo��  ��  �  l     ��������  ��  ��    l     ��������  ��  ��    j   ` h�� �� .0 _defaultequalitycheck _defaultEqualityCheck  I  ` e������
�� .���:ExEqnull��� ��� null��  ��   !"! l     ��������  ��  ��  " #$# l     ��������  ��  ��  $ %&% l     ��'(��  '  -----   ( �)) 
 - - - - -& *+* l     ��,-��  ,   error checking   - �..    e r r o r   c h e c k i n g+ /0/ l     ��������  ��  ��  0 121 l     ��34��  3 � � TO DO: what about checking error record's properties are valid types (e.g. error number should be integer, message should be text, etc.), and fail test if not?   4 �55@   T O   D O :   w h a t   a b o u t   c h e c k i n g   e r r o r   r e c o r d ' s   p r o p e r t i e s   a r e   v a l i d   t y p e s   ( e . g .   e r r o r   n u m b e r   s h o u l d   b e   i n t e g e r ,   m e s s a g e   s h o u l d   b e   t e x t ,   e t c . ) ,   a n d   f a i l   t e s t   i f   n o t ?2 676 l     ��������  ��  ��  7 898 i  i l:;: I     ����<
�� .���:ExErnull��� ��� null��  < ��=��
�� 
Usin= |����>��?��  ��  > o      ���� ,0 errorattributechecks errorAttributeChecks��  ? J      ����  ��  ; l    r@AB@ k     rCC DED Q     fFGHF k    PII JKJ r    LML n   NON I    ��P���� &0 asrecordparameter asRecordParameterP QRQ o    	���� ,0 errorattributechecks errorAttributeChecksR S��S m   	 
TT �UU 
 u s i n g��  ��  O o    ���� 0 _support  M o      ���� ,0 errorattributechecks errorAttributeChecksK VWV r    3XYX K    1ZZ ��[\�� 0 errormessage errorMessage[ o    ���� .0 _defaultequalitycheck _defaultEqualityCheck\ ��]^�� 0 errornumber errorNumber] o    ���� .0 _defaultequalitycheck _defaultEqualityCheck^ ��_`�� 0 	fromvalue 	fromValue_ o    #���� .0 _defaultequalitycheck _defaultEqualityCheck` ��ab�� 0 totype toTypea o   $ )���� .0 _defaultequalitycheck _defaultEqualityCheckb ��c���� 0 partialresult partialResultc o   * /���� .0 _defaultequalitycheck _defaultEqualityCheck��  Y o      ���� :0 defaulterrorattributechecks defaultErrorAttributeChecksW ded r   4 9fgf b   4 7hih o   4 5�� ,0 errorattributechecks errorAttributeChecksi o   5 6�~�~ :0 defaulterrorattributechecks defaultErrorAttributeChecksg o      �}�} 0 checkobjects checkObjectse j�|j l  : Pklmk Z  : Pno�{�zn >   : Apqp n   : =rsr 1   ; =�y
�y 
lengs o   : ;�x�x 0 checkobjects checkObjectsq n   = @tut 1   > @�w
�w 
lengu o   = >�v�v :0 defaulterrorattributechecks defaultErrorAttributeCheckso R   D L�uvw
�u .ascrerr ****      � ****v m   J Kxx �yy � I n v a l i d    u s i n g    p a r a m e t e r   ( r e c o r d   c o n t a i n s   o n e   o r   m o r e   u n r e c o g n i z e d   p r o p e r t i e s ) .w �tz{
�t 
errnz m   F G�s�s�Y{ �r|�q
�r 
erob| o   H I�p�p ,0 errorattributechecks errorAttributeChecks�q  �{  �z  l � � (note: this doesn't bother to check each property's type or that each object has a �compareObjects� handler as any problems there will raise errors if/when those error attributes are checked)   m �}}�   ( n o t e :   t h i s   d o e s n ' t   b o t h e r   t o   c h e c k   e a c h   p r o p e r t y ' s   t y p e   o r   t h a t   e a c h   o b j e c t   h a s   a    c o m p a r e O b j e c t s    h a n d l e r   a s   a n y   p r o b l e m s   t h e r e   w i l l   r a i s e   e r r o r s   i f / w h e n   t h o s e   e r r o r   a t t r i b u t e s   a r e   c h e c k e d )�|  G R      �o~
�o .ascrerr ****      � ****~ o      �n�n 0 etext eText �m��
�m 
errn� o      �l�l 0 enumber eNumber� �k��
�k 
erob� o      �j�j 0 efrom eFrom� �i��h
�i 
errt� o      �g�g 
0 eto eTo�h  H I   X f�f��e�f 
0 _error  � ��� m   Y \�� ��� " e x a c t   e r r o r   c h e c k� ��� o   \ ]�d�d 0 etext eText� ��� o   ] ^�c�c 0 enumber eNumber� ��� o   ^ _�b�b 0 efrom eFrom� ��a� o   _ `�`�` 
0 eto eTo�a  �e  E ��_� h   g r�^��^ "0 exacterrorcheck ExactErrorCheck� i    ��� I      �]��\�]  0 compareobjects compareObjects� ��� o      �[�[ 0 expectederror expectedError� ��Z� o      �Y�Y 0 actualerror actualError�Z  �\  � k     ��� ��� l     �X���X  � � note: `assert test error` normalizes the `expectedError` record prior to calling compareObjects so it will always contain the following properties; any properties that were not supplied by the test script will contain the unique script object `NoValue`   � ����   n o t e :   ` a s s e r t   t e s t   e r r o r `   n o r m a l i z e s   t h e   ` e x p e c t e d E r r o r `   r e c o r d   p r i o r   t o   c a l l i n g   c o m p a r e O b j e c t s   s o   i t   w i l l   a l w a y s   c o n t a i n   t h e   f o l l o w i n g   p r o p e r t i e s ;   a n y   p r o p e r t i e s   t h a t   w e r e   n o t   s u p p l i e d   b y   t h e   t e s t   s c r i p t   w i l l   c o n t a i n   t h e   u n i q u e   s c r i p t   o b j e c t   ` N o V a l u e `� ��� X     ���W�� k   \ ��� ��� l  \ \�V���V  � � � AS fun fact: using `set {a,b,c} to aRef` is hideously slow compared to `set {a,b,c} to contents of aRef` -- TO DO: figure out why   � ���   A S   f u n   f a c t :   u s i n g   ` s e t   { a , b , c }   t o   a R e f `   i s   h i d e o u s l y   s l o w   c o m p a r e d   t o   ` s e t   { a , b , c }   t o   c o n t e n t s   o f   a R e f `   - -   T O   D O :   f i g u r e   o u t   w h y� ��� r   \ u��� n   \ _��� 1   ] _�U
�U 
pcnt� o   \ ]�T�T 0 aref aRef� J      �� ��� o      �S�S $0 expectedproperty expectedProperty� ��� o      �R�R  0 actualproperty actualProperty� ��Q� o      �P�P 0 checkobject checkObject�Q  � ��O� Z   v ����N�M� >  v ��� o   v w�L�L $0 expectedproperty expectedProperty� n  w ~��� o   | ~�K�K 0 novalue NoValue� o   w |�J�J 0 _testsupport _TestSupport� Z  � ����I�H� =  � ���� n  � ���� I   � ��G��F�G  0 compareobjects compareObjects� ��� o   � ��E�E $0 expectedproperty expectedProperty� ��D� o   � ��C�C  0 actualproperty actualProperty�D  �F  � o   � ��B�B 0 checkobject checkObject� m   � ��A
�A boovfals� L   � ��� m   � ��@
�@ boovfals�I  �H  �N  �M  �O  �W 0 aref aRef� J    P�� ��� l 	  ��?�>� J    �� ��� n   ��� o    �=�= 0 errornumber errorNumber� o    �<�< 0 expectederror expectedError� ��� n   	��� o    	�;�; 0 errornumber errorNumber� o    �:�: 0 actualerror actualError� ��9� n   	 ��� o    �8�8 0 errornumber errorNumber� o   	 �7�7 0 checkobjects checkObjects�9  �?  �>  � ��� l 	  !��6�5� J    !�� ��� n   ��� o    �4�4 0 errormessage errorMessage� o    �3�3 0 expectederror expectedError� ��� n   ��� o    �2�2 0 errormessage errorMessage� o    �1�1 0 actualerror actualError� ��0� n    ��� o    �/�/ 0 errormessage errorMessage� o    �.�. 0 checkobjects checkObjects�0  �6  �5  � ��� l 	 ! 0��-�,� J   ! 0�� ��� n  ! $��� o   " $�+�+ 0 	fromvalue 	fromValue� o   ! "�*�* 0 expectederror expectedError� ��� n  $ '��� o   % '�)�) 0 	fromvalue 	fromValue� o   $ %�(�( 0 actualerror actualError� ��'� n   ' .��� o   , .�&�& 0 	fromvalue 	fromValue� o   ' ,�%�% 0 checkobjects checkObjects�'  �-  �,  � ��� l 	 0 ?��$�#� J   0 ?�� ��� n  0 3��� o   1 3�"�" 0 totype toType� o   0 1�!�! 0 expectederror expectedError� ��� n  3 6� � o   4 6� �  0 totype toType  o   3 4�� 0 actualerror actualError� � n   6 = o   ; =�� 0 totype toType o   6 ;�� 0 checkobjects checkObjects�  �$  �#  � � l 	 ? N�� l 
 ? N�� J   ? N 	 n  ? B

 o   @ B�� 0 partialresult partialResult o   ? @�� 0 expectederror expectedError	  n  B E o   C E�� 0 partialresult partialResult o   B C�� 0 actualerror actualError � n   E L o   J L�� 0 partialresult partialResult o   E J�� 0 checkobjects checkObjects�  �  �  �  �  �  � � L   � � m   � ��
� boovtrue�  �_  A q k compare two �class ����� (expected/actual error records) for equality, ignoring any placeholder attributes   B � �   c o m p a r e   t w o   � c l a s s   �   � � �   ( e x p e c t e d / a c t u a l   e r r o r   r e c o r d s )   f o r   e q u a l i t y ,   i g n o r i n g   a n y   p l a c e h o l d e r   a t t r i b u t e s9  l     ����  �  �    l     �
�	��
  �	  �    j   m u�� (0 _defaulterrorcheck _defaultErrorCheck I  m r���
� .���:ExErnull��� ��� null�  �    l     ����  �  �     l     � �����   ��  ��    !"! l     ��#$��  # J D--------------------------------------------------------------------   $ �%% � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -" &'& l     ��()��  (   Unit Test Assertions    ) �** ,   U n i t   T e s t   A s s e r t i o n s  ' +,+ l     ��������  ��  ��  , -.- i  v y/0/ I      ��1���� 20 _ascheckobjectparameter _asCheckObjectParameter1 232 o      ���� 0 checkobject checkObject3 4��4 o      ���� (0 defaultcheckobject defaultCheckObject��  ��  0 k     <55 676 Z    89����8 =    :;: o     ���� 0 checkobject checkObject; m    ��
�� 
msng9 r    	<=< o    ���� (0 defaultcheckobject defaultCheckObject= o      ���� 0 checkobject checkObject��  ��  7 >?> r    @A@ n   BCB I    ��D���� &0 asscriptparameter asScriptParameterD EFE o    ���� 0 checkobject checkObjectF G��G m    HH �II 
 u s i n g��  ��  C o    ���� 0 _support  A o      ���� 0 checkobject checkObject? JKJ Z   9LM����L H    *NN n   )OPO I   ! )��Q���� 0 
hashandler 
hasHandlerQ R��R N   ! %SS n   ! $TUT o   " $����  0 compareobjects compareObjectsU o   ! "���� 0 checkobject checkObject��  ��  P o    !���� 0 _support  M R   - 5��VW
�� .ascrerr ****      � ****V m   3 4XX �YY � B a d    u s i n g    p a r a m e t e r   ( s c r i p t   o b j e c t   d o e s n  t   c o n t a i n   a    c o m p a r e O b j e c t s    h a n d l e r ) .W ��Z[
�� 
errnZ m   / 0�����@[ ��\��
�� 
erob\ o   1 2���� 0 checkobject checkObject��  ��  ��  K ]��] L   : <^^ o   : ;���� 0 checkobject checkObject��  . _`_ l     ��������  ��  ��  ` aba i  z }cdc I      ��e���� .0 _compareassertresults _compareAssertResultse fgf o      ���� 0 checkobject checkObjectg hih o      ����  0 expectedresult expectedResulti jkj o      ���� 0 actualresult actualResultk lml o      ���� 0 
assertname 
assertNamem n��n o      ���� 0 usernote userNote��  ��  d Q     Copqo L    rr n   
sts I    
��u����  0 compareobjects compareObjectsu vwv o    ����  0 expectedresult expectedResultw x��x o    ���� 0 actualresult actualResult��  ��  t o    ���� 0 checkobject checkObjectp R      ��yz
�� .ascrerr ****      � ****y o      ���� 0 etext eTextz ��{|
�� 
errn{ o      ���� 0 enumber eNumber| ��}~
�� 
erob} o      ���� 0 efrom eFrom~ ���
�� 
errt o      ���� 
0 eto eTo� �����
�� 
ptlr� o      ���� 0 epartial ePartial��  q k    C�� ��� n   2��� I    2������� 0 	addbroken 	addBroken� ��� o    ���� 0 
assertname 
assertName� ��� m    �� ��� D b r o k e   d u e   t o   e r r o r   i n   c h e c k   o b j e c t� ��� o    ���� 0 usernote userNote� ���� l 	  .������ J    .�� ���� J    ,�� ��� m    �� ���   u n e x p e c t e d   e r r o r� ���� n   *��� I   ! *������� .0 makecaughterrorrecord makeCaughtErrorRecord� ��� o   ! "���� 0 etext eText� ��� o   " #���� 0 enumber eNumber� ��� o   # $���� 0 efrom eFrom� ��� o   $ %���� 
0 eto eTo� ���� o   % &���� 0 epartial ePartial��  ��  � o    !���� 0 _testsupport _TestSupport��  ��  ��  ��  ��  ��  � o    ���� 0 _testreport _testReport� ���� R   3 C�����
�� .ascrerr ****      � ****��  � ����
�� 
errn� o   5 :���� 00 _abortedassertionerror _AbortedAssertionError� �����
�� 
erob� o   ; @���� 00 _abortedassertiontoken _AbortedAssertionToken��  ��  b ��� l     ��������  ��  ��  � ��� l     ������  �  -----   � ��� 
 - - - - -� ��� l     ��������  ��  ��  � ��� i  ~ ���� I     �����
�� .���:AsRenull��� ��� null��  � ����
�� 
Valu� o      ���� 0 actualresult actualResult� ����
�� 
Equa� o      ����  0 expectedresult expectedResult� ����
�� 
Summ� |����������  ��  � o      ���� 0 usernote userNote��  � l     ������ m      �� ���  ��  ��  � �����
�� 
Usin� |����������  ��  � o      ���� 0 checkobject checkObject��  � l     ������ m      ��
�� 
msng��  ��  ��  � k     ��� ��� Z    ������� =    ��� o     ���� $0 _testsuiteobject _testSuiteObject� m    ��
�� 
msng� R   
 ���
� .ascrerr ****      � ****� m    �� ��� d C a n n o t    a s s e r t   t e s t   r e s u l t    o u t s i d e   o f   u n i t   t e s t s .� �~��}
�~ 
errn� m    �|�|�T�}  ��  ��  � ��{� P    ����� k    ��� ��� Q    v���� k    8�� ��� r    *��� n   (��� I   " (�z��y�z "0 astextparameter asTextParameter� ��� o   " #�x�x 0 usernote userNote� ��w� m   # $�� ���  s u m m a r y�w  �y  � o    "�v�v 0 _support  � o      �u�u 0 usernote userNote� ��t� r   + 8��� I   + 6�s��r�s 20 _ascheckobjectparameter _asCheckObjectParameter� ��� o   , -�q�q 0 checkobject checkObject� ��p� o   - 2�o�o .0 _defaultequalitycheck _defaultEqualityCheck�p  �r  � o      �n�n 0 checkobject checkObject�t  � R      �m��
�m .ascrerr ****      � ****� o      �l�l 0 etext eText� �k��
�k 
errn� o      �j�j 0 enumber eNumber� �i��
�i 
erob� o      �h�h 0 efrom eFrom� �g��
�g 
errt� o      �f�f 
0 eto eTo� �e��d
�e 
ptlr� o      �c�c 0 epartial ePartial�d  � k   @ v�� ��� n  @ a��� I   E a�b �a�b 0 	addbroken 	addBroken   m   E F � $ a s s e r t   t e s t   r e s u l t  m   F G � . r e c e i v e d   b a d   p a r a m e t e r s 	
	 o   G H�`�` 0 usernote userNote
 �_ l 	 H [�^�] J   H [ �\ J   H Y  m   H I �   u n e x p e c t e d   e r r o r �[ n  I W I   N W�Z�Y�Z .0 makecaughterrorrecord makeCaughtErrorRecord  o   N O�X�X 0 etext eText  o   O P�W�W 0 enumber eNumber  o   P Q�V�V 0 efrom eFrom  o   Q R�U�U 
0 eto eTo  �T  o   R S�S�S 0 epartial ePartial�T  �Y   o   I N�R�R 0 _testsupport _TestSupport�[  �\  �^  �]  �_  �a  � o   @ E�Q�Q 0 _testreport _testReport� !�P! R   b v�O�N"
�O .ascrerr ****      � ****�N  " �M#$
�M 
errn# o   d i�L�L 00 _abortedassertionerror _AbortedAssertionError$ �K%�J
�K 
erob% o   l q�I�I 00 _abortedassertiontoken _AbortedAssertionToken�J  �P  � &'& r   w �()( I   w ��H*�G�H .0 _compareassertresults _compareAssertResults* +,+ o   x y�F�F 0 checkobject checkObject, -.- o   y z�E�E  0 expectedresult expectedResult. /0/ o   z {�D�D 0 actualresult actualResult0 121 m   { ~33 �44 $ a s s e r t   t e s t   r e s u l t2 5�C5 o   ~ �B�B 0 usernote userNote�C  �G  ) o      �A�A 0 isequal isEqual' 676 r   � �898 J   � �:: ;<; J   � �== >?> m   � �@@ �AA  e x p e c t e d   r e s u l t? B�@B o   � ��?�?  0 expectedresult expectedResult�@  < C�>C J   � �DD EFE m   � �GG �HH  a c t u a l   r e s u l tF I�=I o   � ��<�< 0 actualresult actualResult�=  �>  9 o      �;�; 0 testdata testData7 J�:J Z   � �KL�9MK o   � ��8�8 0 isequal isEqualL k   � �NN OPO n  � �QRQ I   � ��7S�6�7 0 
addsuccess 
addSuccessS TUT m   � �VV �WW $ a s s e r t   t e s t   r e s u l tU XYX o   � ��5�5 0 usernote userNoteY Z�4Z o   � ��3�3 0 testdata testData�4  �6  R o   � ��2�2 0 _testreport _testReportP [�1[ L   � ��0�0  �1  �9  M k   � �\\ ]^] n  � �_`_ I   � ��/a�.�/ 0 
addfailure 
addFailurea bcb m   � �dd �ee $ a s s e r t   t e s t   r e s u l tc fgf m   � �hh �ii 2 r e c e i v e d   i n c o r r e c t   r e s u l tg jkj o   � ��-�- 0 usernote userNotek l�,l o   � ��+�+ 0 testdata testData�,  �.  ` o   � ��*�* 0 _testreport _testReport^ m�)m R   � ��(�'n
�( .ascrerr ****      � ****�'  n �&op
�& 
errno o   � ��%�% 00 _abortedassertionerror _AbortedAssertionErrorp �$q�#
�$ 
erobq o   � ��"�" 00 _abortedassertiontoken _AbortedAssertionToken�#  �)  �:  � �!r
�! conscaser � s
�  consdiacs �t
� conshypht �u
� conspuncu ��
� conswhit�  � ��
� consnume�  �{  � vwv l     ����  �  �  w xyx l     ����  �  �  y z{z i  � �|}| I     ��~
� .���:AsErnull��� ��� null�  ~ ��
� 
Hand |������  �  � o      �� "0 callhandlername callHandlerName�  � l     ���� m      �� ���  �  �  � �
��
�
 
Args� |�	�����	  �  � o      ��  0 parametervalue parameterValue�  � l     ���� m      �
� 
���!�  �  � ���
� 
Equa� o      �� 0 expectederror expectedError� � ��
�  
Summ� |����������  ��  � o      ���� 0 usernote userNote��  � l     ������ m      �� ���  ��  ��  � �����
�� 
Usin� |����������  ��  � o      ���� 0 checkobject checkObject��  � l     ������ m      ��
�� 
msng��  ��  ��  } k    R�� ��� Z    ������� =    ��� o     ���� $0 _testsuiteobject _testSuiteObject� m    ��
�� 
msng� R   
 ����
�� .ascrerr ****      � ****� m    �� ��� b C a n n o t    a s s e r t   t e s t   e r r o r    o u t s i d e   o f   u n i t   t e s t s .� �����
�� 
errn� m    �����T��  ��  ��  � ���� P   R���� k   Q�� ��� Q    ����� k    a�� ��� r    *��� n   (��� I   " (������� "0 astextparameter asTextParameter� ��� o   " #���� "0 callhandlername callHandlerName� ���� m   # $�� ���  i n��  ��  � o    "���� 0 _support  � o      ���� "0 callhandlername callHandlerName� ��� r   + 8��� n  + 6��� I   0 6������� &0 asrecordparameter asRecordParameter� ��� o   0 1���� 0 expectederror expectedError� ���� m   1 2�� ���  i s��  ��  � o   + 0���� 0 _support  � o      ���� 0 expectederror expectedError� ��� r   9 E��� n  9 C��� I   > C������� <0 normalizeexpectederrorrecord normalizeExpectedErrorRecord� ���� o   > ?���� 0 expectederror expectedError��  ��  � o   9 >���� 0 _testsupport _TestSupport� o      ���� 0 expectederror expectedError� ��� l  F F������  � � � TO DO: what about checking expectedError record's properties are valid types (e.g. error number should be integer, message should be text, etc.), and abort with broken test if not   � ���h   T O   D O :   w h a t   a b o u t   c h e c k i n g   e x p e c t e d E r r o r   r e c o r d ' s   p r o p e r t i e s   a r e   v a l i d   t y p e s   ( e . g .   e r r o r   n u m b e r   s h o u l d   b e   i n t e g e r ,   m e s s a g e   s h o u l d   b e   t e x t ,   e t c . ) ,   a n d   a b o r t   w i t h   b r o k e n   t e s t   i f   n o t� ��� r   F S��� n  F Q��� I   K Q������� "0 astextparameter asTextParameter� ��� o   K L���� 0 usernote userNote� ���� m   L M�� ���  s u m m a r y��  ��  � o   F K���� 0 _support  � o      ���� 0 usernote userNote� ���� r   T a��� I   T _������� 20 _ascheckobjectparameter _asCheckObjectParameter� ��� o   U V���� 0 checkobject checkObject� ���� o   V [���� (0 _defaulterrorcheck _defaultErrorCheck��  ��  � o      ���� 0 checkobject checkObject��  � R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� ����
�� 
errt� o      ���� 
0 eto eTo� �����
�� 
ptlr� o      ���� 0 epartial ePartial��  � k   i ��� ��� n  i ���� I   n �������� 0 	addbroken 	addBroken� ��� m   n o�� ��� " a s s e r t   t e s t   e r r o r� ��� m   o r�� ��� . r e c e i v e d   b a d   p a r a m e t e r s� ��� o   r s���� 0 usernote userNote�  ��  l 	 s ����� J   s � �� J   s �  m   s v �   u n e x p e c t e d   e r r o r 	��	 n  v �

 I   { ������� .0 makecaughterrorrecord makeCaughtErrorRecord  o   { |���� 0 etext eText  o   | }���� 0 enumber eNumber  o   } ~���� 0 efrom eFrom  o   ~ ���� 
0 eto eTo �� o    ����� 0 epartial ePartial��  ��   o   v {���� 0 _testsupport _TestSupport��  ��  ��  ��  ��  ��  � o   i n���� 0 _testreport _testReport� �� R   � �����
�� .ascrerr ****      � ****��   ��
�� 
errn o   � ����� 00 _abortedassertionerror _AbortedAssertionError ����
�� 
erob o   � ����� 00 _abortedassertiontoken _AbortedAssertionToken��  ��  �  l  � �����   G A code-generate a script object to invoke the `call_NAME` handler�    � �   c o d e - g e n e r a t e   a   s c r i p t   o b j e c t   t o   i n v o k e   t h e   ` c a l l _ N A M E `   h a n d l e r &  !  P   � �"��#" Z   � �$%&��$ =  � �'(' o   � ����� "0 callhandlername callHandlerName( m   � �)) �**  % l  � �+,-+ r   � �./. b   � �010 m   � �22 �33  c a l l1 l  � �4����4 n   � �565 7  � ���78
�� 
ctxt7 m   � ����� 8 m   � �������6 o   � ����� $0 _testhandlername _testHandlerName��  ��  / o      ���� "0 callhandlername callHandlerName, | v if `for` parameter is omitted, automatically call a `call_NAME` handler with the same NAME as the `test_NAME` handler   - �99 �   i f   ` f o r `   p a r a m e t e r   i s   o m i t t e d ,   a u t o m a t i c a l l y   c a l l   a   ` c a l l _ N A M E `   h a n d l e r   w i t h   t h e   s a m e   N A M E   a s   t h e   ` t e s t _ N A M E `   h a n d l e r& :;: H   � �<< C   � �=>= o   � ����� "0 callhandlername callHandlerName> m   � �?? �@@ 
 c a l l _; A��A r   � �BCB b   � �DED m   � �FF �GG 
 c a l l _E o   � ����� "0 callhandlername callHandlerNameC o      ���� "0 callhandlername callHandlerName��  ��  ��  # ����
�� conscase��  ! HIH Z   �JK��LJ =  � �MNM o   � �����  0 parametervalue parameterValueN m   � ���
�� 
���!K r   � �OPO n  � �QRQ I   � ���S����  0 makecallobject makeCallObjectS TUT o   � ����� "0 callhandlername callHandlerNameU V��V m   � �����  ��  ��  R o   � ����� 0 _testsupport _TestSupportP o      ���� 0 
callobject 
callObject��  L r   �WXW n  �
YZY I  
��[����  0 makecallobject makeCallObject[ \]\ o  ���� "0 callhandlername callHandlerName] ^��^ m  ���� ��  ��  Z o   ����� 0 _testsupport _TestSupportX o      ���� 0 
callobject 
callObjectI _`_ l ��ab��  a   �then call it   b �cc    & t h e n   c a l l   i t` ded l >fghf r  >iji J  "kk lml n non o  �� 0 novalue NoValueo o  �~�~ 0 _testsupport _TestSupportm pqp n rsr o  �}�} 0 novalue NoValues o  �|�| 0 _testsupport _TestSupportq t�{t m   �z
�z boovfals�{  j J      uu vwv o      �y�y 0 actualerror actualErrorw xyx o      �x�x 0 actualresult actualResulty z�wz o      �v�v 0 isequal isEqual�w  g \ V TO DO: rename isEqual to isSuccess once 'is equal' test code is moved to Check object   h �{{ �   T O   D O :   r e n a m e   i s E q u a l   t o   i s S u c c e s s   o n c e   ' i s   e q u a l '   t e s t   c o d e   i s   m o v e d   t o   C h e c k   o b j e c te |}| Q  ?z~�~ l BO���� r  BO��� n BM��� I  CM�u��t�u 0 dotest doTest� ��� o  CH�s�s $0 _testsuiteobject _testSuiteObject� ��r� o  HI�q�q  0 parametervalue parameterValue�r  �t  � o  BC�p�p 0 
callobject 
callObject� o      �o�o 0 actualresult actualResult� n h note: this may return literal 'no value' due to AS's schlonky design - this will be accounted for below   � ��� �   n o t e :   t h i s   m a y   r e t u r n   l i t e r a l   ' n o   v a l u e '   d u e   t o   A S ' s   s c h l o n k y   d e s i g n   -   t h i s   w i l l   b e   a c c o u n t e d   f o r   b e l o w R      �n��
�n .ascrerr ****      � ****� o      �m�m 0 etext eText� �l��
�l 
errn� o      �k�k 0 enumber eNumber� �j��
�j 
erob� o      �i�i 0 efrom eFrom� �h��
�h 
errt� o      �g�g 
0 eto eTo� �f��e
�f 
ptlr� o      �d�d 0 epartial ePartial�e  � k  Wz�� ��� l WW�c���c  � y s compare expected vs actual error info, ignoring any actual error info that user-supplied record doesn't care about   � ��� �   c o m p a r e   e x p e c t e d   v s   a c t u a l   e r r o r   i n f o ,   i g n o r i n g   a n y   a c t u a l   e r r o r   i n f o   t h a t   u s e r - s u p p l i e d   r e c o r d   d o e s n ' t   c a r e   a b o u t� ��� r  Wi��� n Wg��� I  \g�b��a�b .0 makecaughterrorrecord makeCaughtErrorRecord� ��� o  \]�`�` 0 etext eText� ��� o  ]^�_�_ 0 enumber eNumber� ��� o  ^_�^�^ 0 efrom eFrom� ��� o  _`�]�] 
0 eto eTo� ��\� o  `a�[�[ 0 epartial ePartial�\  �a  � o  W\�Z�Z 0 _testsupport _TestSupport� o      �Y�Y 0 actualerror actualError� ��X� r  jz��� I  jx�W��V�W .0 _compareassertresults _compareAssertResults� ��� o  kl�U�U 0 checkobject checkObject� ��� o  lm�T�T 0 expectederror expectedError� ��� o  mn�S�S 0 actualerror actualError� ��� m  nq�� ��� " a s s e r t   t e s t   e r r o r� ��R� o  qr�Q�Q 0 usernote userNote�R  �V  � o      �P�P 0 isequal isEqual�X  } ��� r  {���� J  {��� ��O� J  {��� ��� m  {~�� ���  e x p e c t e d   e r r o r� ��N� o  ~�M�M 0 expectederror expectedError�N  �O  � o      �L�L 0 testdata testData� ��K� Z  �Q���J�� o  ���I�I 0 isequal isEqual� l ������ k  ���� ��� n ����� I  ���H��G�H 0 
addsuccess 
addSuccess� ��� m  ���� ��� " a s s e r t   t e s t   e r r o r� ��� o  ���F�F 0 usernote userNote� ��E� b  ����� o  ���D�D 0 testdata testData� J  ���� ��C� J  ���� ��� m  ���� ���  a c t u a l   e r r o r� ��B� o  ���A�A 0 actualerror actualError�B  �C  �E  �G  � o  ���@�@ 0 _testreport _testReport� ��?� L  ���>�>  �?  �   success   � ���    s u c c e s s�J  � l �Q���� k  �Q�� ��� Q  ������ l ������ l ������ r  ����� o  ���=�= 0 actualresult actualResult� o      �<�< 0 actualresult actualResult� � z this variable lookup fails if call_NAME returned nothing (i.e. `null`, which AS literally treats as 'no value at all')...   � ��� �   t h i s   v a r i a b l e   l o o k u p   f a i l s   i f   c a l l _ N A M E   r e t u r n e d   n o t h i n g   ( i . e .   ` n u l l ` ,   w h i c h   A S   l i t e r a l l y   t r e a t s   a s   ' n o   v a l u e   a t   a l l ' ) . . .� g a kludge-around for AS's dumb commands-are-not-expressions-so-do-not-have-to-return-results design   � ��� �   k l u d g e - a r o u n d   f o r   A S ' s   d u m b   c o m m a n d s - a r e - n o t - e x p r e s s i o n s - s o - d o - n o t - h a v e - t o - r e t u r n - r e s u l t s   d e s i g n� R      �;�:�
�; .ascrerr ****      � ****�:  � �9��8
�9 
errn� d      �� m      �7�7
��8  � l ������ r  ��	 		  n ��			 o  ���6�6 0 novalue NoValue	 o  ���5�5 0 _testsupport _TestSupport	 o      �4�4 0 actualresult actualResult� a [ ... in which case replace it with a 'no value placeholder' object that AS can actually see   � �		 �   . . .   i n   w h i c h   c a s e   r e p l a c e   i t   w i t h   a   ' n o   v a l u e   p l a c e h o l d e r '   o b j e c t   t h a t   A S   c a n   a c t u a l l y   s e e� 			 Z ��		�3�2	 > ��			
		 o  ���1�1 0 actualerror actualError	
 n ��			 o  ���0�0 0 novalue NoValue	 o  ���/�/ 0 _testsupport _TestSupport	 r  ��			 J  ��		 			 m  ��		 �		 0 r e c e i v e d   i n c o r r e c t   e r r o r	 	�.	 b  ��			 o  ���-�- 0 testdata testData	 J  ��		 	�,	 J  ��		 			 m  ��		 �		  a c t u a l   e r r o r	 	�+	 o  ���*�* 0 actualerror actualError�+  �,  �.  	 J      		 	 	!	  o      �)�) 0 problemtype problemType	! 	"�(	" o      �'�' 0 testdata testData�(  �3  �2  	 	#	$	# Z �*	%	&�&�%	% > �	'	(	' o  ���$�$ 0 actualresult actualResult	( n � 	)	*	) o  � �#�# 0 novalue NoValue	* o  ���"�" 0 _testsupport _TestSupport	& r  &	+	,	+ J  	-	- 	.	/	. m  	0	0 �	1	1 " r e c e i v e d   n o   e r r o r	/ 	2�!	2 b  	3	4	3 o  � �  0 testdata testData	4 J  	5	5 	6�	6 J  	7	7 	8	9	8 m  	:	: �	;	; " u n e x p e c t e d   r e s u l t	9 	<�	< o  �� 0 actualresult actualResult�  �  �!  	, J      	=	= 	>	?	> o      �� 0 problemtype problemType	? 	@�	@ o      �� 0 testdata testData�  �&  �%  	$ 	A	B	A n +<	C	D	C I  0<�	E�� 0 
addfailure 
addFailure	E 	F	G	F m  03	H	H �	I	I " a s s e r t   t e s t   e r r o r	G 	J	K	J o  34�� 0 problemtype problemType	K 	L	M	L o  45�� 0 usernote userNote	M 	N�	N o  56�� 0 testdata testData�  �  	D o  +0�� 0 _testreport _testReport	B 	O�	O R  =Q��	P
� .ascrerr ****      � ****�  	P �	Q	R
� 
errn	Q o  ?D�� 00 _abortedassertionerror _AbortedAssertionError	R �	S�
� 
erob	S o  GL�� 00 _abortedassertiontoken _AbortedAssertionToken�  �  � 2 , raised wrong error or didn't raise an error   � �	T	T X   r a i s e d   w r o n g   e r r o r   o r   d i d n ' t   r a i s e   a n   e r r o r�K  � �
	U
�
 conscase	U �		V
�	 consdiac	V �	W
� conshyph	W �	X
� conspunc	X ��
� conswhit�  � ��
� consnume�  ��  { 	Y	Z	Y l     ��� �  �  �   	Z 	[	\	[ l     ��������  ��  ��  	\ 	]��	] l     ��������  ��  ��  ��       ��	^	_	`	a	b	c	d��	e��������	f	g	h	i	j	k	l	m	n	o	p��  	^ ����������������������������������������������
�� 
pimr�� 0 _support  �� 
0 _error  �� 0 _testsupport _TestSupport�� 0 
randomword 
randomWord
�� .���:MTmrnull��� ��� ctxt�� 00 _abortedassertionerror _AbortedAssertionError�� 00 _abortedassertiontoken _AbortedAssertionToken�� $0 _testsuiteobject _testSuiteObject�� 0 _testreport _testReport�� $0 _testhandlername _testHandlerName�� 0 
_skipsuite 
_SKIPSUITE�� 0 __performunittestforsuite__  
�� .���:ExEqnull��� ��� null
�� .���:NmEqnull��� ��� null
�� .���:NmRgnull��� ��� null�� .0 _defaultequalitycheck _defaultEqualityCheck
�� .���:ExErnull��� ��� null�� (0 _defaulterrorcheck _defaultErrorCheck�� 20 _ascheckobjectparameter _asCheckObjectParameter�� .0 _compareassertresults _compareAssertResults
�� .���:AsRenull��� ��� null
�� .���:AsErnull��� ��� null	_ ��	q�� 	q  	r	s	r ��	t��
�� 
cobj	t 	u	u   �� 
�� 
frmk��  	s ��	v��
�� 
cobj	v 	w	w   ��
�� 
osax��  	` 	x	x   �� -
�� 
scpt	a �� 5����	y	z���� 
0 _error  �� ��	{�� 	{  ������������ 0 handlername handlerName�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo��  	y ������������ 0 handlername handlerName�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo	z  E������ �� &0 throwcommanderror throwCommandError�� b  ࠡ����+ 	b 	|	|   �� \
�� 
scpt	c �� r����	}	~���� 0 
randomword 
randomWord�� ��	�� 	  ������ 0 	minlength 	minLength�� 0 	maxlength 	maxLength��  	} �������� 0 	minlength 	minLength�� 0 	maxlength 	maxLength�� 0 s  	~  ���������� ���
�� misccura
�� 
from
�� 
to  �� 
�� .sysorandnmbr    ��� nmbr
�� 
cobj�� (�E�O � *��� Ukh���.%E�[OY��O�	d �� �����	�	���
�� .���:MTmrnull��� ��� ctxt�� {���� ��� 0 nametext nameText��  ��  	� ������ 0 nametext nameText�� 0 timerobject TimerObject	� �� �	��� 0 timerobject TimerObject	� ��	�����	�	���
�� .ascrinit****      � ****	� k     '	�	�  �	�	�  �	�	�  �	�	�  �	�	�  �	�	�  �	�	�  �	�	� 	�	� ����  ��  ��  	� 	������������������
�� 
pimr�� 0 
_starttime 
_startTime�� 0 _totalseconds _totalSeconds�� 0 
_isrunning 
_isRunning�� 0 	timername 	timerName�� 0 
starttimer 
startTimer�� 0 	stoptimer 	stopTimer�� 0 elapsedtime elapsedTime�� 0 	totaltime 	totalTime	� ���� ����� �����	�	�	�	�	�
�� 
cobj
�� 
frmk
�� 
msng�� 0 
_starttime 
_startTime�� 0 _totalseconds _totalSeconds�� 0 
_isrunning 
_isRunning	� �� �����	�	����� 0 	timername 	timerName��  ��  	�  	�  �� b   	� �� �����	�	����� 0 
starttimer 
startTimer��  ��  	�  	� ������
�� misccura�� 0 nsdate NSDate�� @0 timeintervalsincereferencedate timeIntervalSinceReferenceDate�� (b   hY hOeEc  O��,j+ Ec  O)	� �� �����	�	����� 0 	stoptimer 	stopTimer��  ��  	� ���� 0 elapsedtime elapsedTime	� ������
�� misccura�� 0 nsdate NSDate�� @0 timeintervalsincereferencedate timeIntervalSinceReferenceDate�� 9b   jY hO��,j+ b  E�Ob  �Ec  OfEc  O�	� �����	�	��~�� 0 elapsedtime elapsedTime��  �  	� �}�} 0 nsdate NSDate	� �|�| @0 timeintervalsincereferencedate timeIntervalSinceReferenceDate�~ b   �j+  b  Y j	� �{�z�y	�	��x�{ 0 	totaltime 	totalTime�z  �y  	�  	� �w�w 0 elapsedtime elapsedTime�x b   b  *j+  Y b  �� (�*��/lkv��O�Of�OL OL 	OL 
OL OL �� ��K S���A	e �v@  	��v 00 _abortedassertiontoken _AbortedAssertionToken	�  	�	�  
�� 
msng
�� 
msng
�� 
msng�� c	f �u��t�s	�	��r�u 0 __performunittestforsuite__  �t �q	��q 	�  �p	��p 0 suiteobject suiteObject	� �o	��o 	�  �n�m�l�n 0 	suitename 	suiteName�m 0 handlername handlerName�l 0 isstyled isStyled�s  	� �k�j�i�h�g�f�e�d�c�b�a�`�k 0 suiteobject suiteObject�j 0 	suitename 	suiteName�i 0 handlername handlerName�h 0 isstyled isStyled�g 0 skipinfo skipInfo�f 0 
skipreason 
skipReason�e 0 etext eText�d 0 enumber eNumber�c 0 efrom eFrom�b 
0 eto eTo�a 0 epartial ePartial�` 0 
callobject 
callObject	� 6�_�^�]�\	��[�Z�Y�X�W�V�U�T��S�R�Q�P�O�N	��M�LL�K�J	�tx|��I�H�G�F�E�����D�C�B,09�A�@nrv�_  0 maketestreport makeTestReport�^ *0 configure_skiptests configure_skipTests�] 0 
hashandler 
hasHandler�\  	� �?�>�=
�? 
errn�>�?�=  
�[ 
errn�Z�?
�Y 
erob
�X 
errt
�W 
reco
�V 
ctxt
�U 
msng�T �S 0 istype isType
�R misccura�Q 0 nsdictionary NSDictionary�P 60 dictionarywithdictionary_ dictionaryWithDictionary_�O 0 objectforkey_ objectForKey_
�N 
****	� �<�;�:
�< 
errn�;�\�:  �M�\�L 0 
addskipped 
addSkipped�K 0 	skipsuite 	skipSuite�J 0 etext eText	� �9�8	�
�9 
errn�8 0 enumber eNumber	� �7�6	�
�7 
erob�6 0 efrom eFrom	� �5�4	�
�5 
errt�4 
0 eto eTo	� �3�2�1
�3 
ptlr�2 0 epartial ePartial�1  �I �H .0 makecaughterrorrecord makeCaughtErrorRecord�G �F 0 	addbroken 	addBroken�E "0 configure_setup configure_setUp�D  0 makecallobject makeCallObject�C 0 dotest doTest
�B 
bool�A 0 
addfailure 
addFailure�@ (0 configure_teardown configure_tearDown�r}b  ���m+  Ec  	Ob  ��,k+ ! �j+ E�O �E�W X  )�������mv��Ob  	O�� �b  ��l+  _�a ,�k+ �k+ a &E�O�� ? 
��&E�W X  )�a ����lv�a �%a %Ob  	��l+ Ob  	Y hY @�� 9 
��&E�W X  )�a �����mv�a Ob  	�k+ Ob  	Y hY hW 9X  b  	a a a a  b  �����a !+ "lvkva #+ $Ob  	Y hO�Ec  O�Ec  
Ob  �a %,k+  O 
�j+ %W AX  b  	a &a 'a (a )b  �����a !+ "lvkva #+ $O�Ec  Ob  	Y hOb  �jl+ *E�O ���l+ +W MX  �b   	 �b   a ,& .b  	�a -a .a /b  �����a !+ "lvkva #+ 0Y hOb  �a 1,k+  @ 
�j+ 1W 2X  b  	a 2a 3a 4a 5b  �����a !+ "lvkva #+ $Y hO�Ec  Ob  		g �0��/�.	�	��-
�0 .���:ExEqnull��� ��� null�/  �.  	� �,�, (0 exactequalitycheck ExactEqualityCheck	� �+�	��+ (0 exactequalitycheck ExactEqualityCheck	� �*	��)�(	�	��'
�* .ascrinit****      � ****	� k     	�	� ��&�&  �)  �(  	� �%�%  0 compareobjects compareObjects	� 	�	� �$��#�"	�	��!�$  0 compareobjects compareObjects�# � 	��  	�  ��� 0 expectedvalue expectedValue� 0 actualvalue actualValue�"  	� ��� 0 expectedvalue expectedValue� 0 actualvalue actualValue	� ���
� 
pcls�! �� ��,��, fY hO�� V�' L  �- ��K S�	h ����	�	��
� .���:NmEqnull��� ��� null�  � �	��
� 
ETyp	� {���� (0 issametyperequired isSameTypeRequired�  
� boovtrue�  	� �������� (0 issametyperequired isSameTypeRequired� 0 	checktype 	checkType� 00 numericalequalitycheck NumericalEqualityCheck� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo	� ��
�	���	��	�v���
 (0 asbooleanparameter asBooleanParameter
�	 
doub
� 
nmbr� 00 numericalequalitycheck NumericalEqualityCheck	� �	���	�	�� 
� .ascrinit****      � ****	� k     	�	� �	�	� ����  �  �  	� ������ 0 _isequaldelta _isEqualDelta��  0 compareobjects compareObjects	� ��	��� 0 _isequaldelta _isEqualDelta	� ������	�	�����  0 compareobjects compareObjects�� ��	��� 	�  ������ 0 expectedvalue expectedValue�� 0 actualvalue actualValue��  	� ���������������� 0 expectedvalue expectedValue�� 0 actualvalue actualValue�� 0 n1  �� 0 n2  �� 0 d1  �� 0 d2  �� 0 d  	� ������������
�� 
kocl
�� 
long
�� .corecnte****       ****
�� 
doub
�� 
cobj
�� 
bool�� ���lv��l l  	�� Y hO��lv�b  l l fY hO��&��&lvE[�k/E�Z[�l/E�ZO�j  b   � E�Y b   � E�O�'E�O�� ��lvE[�k/E�Z[�l/E�ZY hO��E�O��	 ���&�  �OL � 0 etext eText	� ����	�
�� 
errn�� 0 enumber eNumber	� ����	�
�� 
erob�� 0 efrom eFrom	� ������
�� 
errt�� 
0 eto eTo��  � � 
0 _error  � 5 $b  ��l+  �E�Y �E�O��K S�W X  *飤���+ 	i �������	�	���
�� .���:NmRgnull��� ��� null��  �� ��	���
�� 
ETyp	� {�������� (0 issametyperequired isSameTypeRequired��  
�� boovtrue��  	� �������������� (0 issametyperequired isSameTypeRequired�� *0 numericalrangecheck NumericalRangeCheck�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo	� 
������	���	������� (0 asbooleanparameter asBooleanParameter�� *0 numericalrangecheck NumericalRangeCheck	� ��	�����	�	���
�� .ascrinit****      � ****	� k     	�	� �����  ��  ��  	� ����  0 compareobjects compareObjects	� 	�	� �������	�	�����  0 compareobjects compareObjects�� ��	��� 	�  ������ 0 expectedvalue expectedValue�� 0 actualvalue actualValue��  	� ������������ 0 expectedvalue expectedValue�� 0 actualvalue actualValue�� "0 expectedminimum expectedMinimum�� "0 expectedmaximum expectedMaximum�� 0 	checktype 	checkType	� ������������������������
�� 
kocl
�� 
list
�� .corecnte****       ****
�� 
nmbr
�� 
bool
�� 
cobj
�� 
errn���Y
�� 
erob�� 
�� 
pcls�� ��kv��l j 
 ���l l�&
 ��k/��l/�& )�����Y hO�E[�k/E�Z[�l/E�ZOb    !��,��, )�����Y hO��,E�Y �E�O�kv�l j  fY hO��	 ���&�� L  �� 0 etext eText	� ����	�
�� 
errn�� 0 enumber eNumber	� ����	�
�� 
erob�� 0 efrom eFrom	� ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� + b  ��l+ E�O��K S�W X  *碣���+ 		j ���  	��� (0 exactequalitycheck ExactEqualityCheck	� ��	�	���  	k ��;����	�	���
�� .���:ExErnull��� ��� null��  �� ��	���
�� 
Usin	� {�������� ,0 errorattributechecks errorAttributeChecks��  ��  ��  	� ������������������ ,0 errorattributechecks errorAttributeChecks�� :0 defaulterrorattributechecks defaultErrorAttributeChecks�� 0 checkobjects checkObjects�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo�� "0 exacterrorcheck ExactErrorCheck	� T������������������������x��	���������	��� &0 asrecordparameter asRecordParameter�� 0 errormessage errorMessage�� 0 errornumber errorNumber�� 0 	fromvalue 	fromValue�� 0 totype toType�� 0 partialresult partialResult�� 

�� 
leng
�� 
errn���Y
�� 
erob�� �� 0 etext eText	� ����	�
�� 
errn�� 0 enumber eNumber	� ����	�
�� 
erob�� 0 efrom eFrom	� �����
�� 
errt�� 
0 eto eTo�  �� �� 
0 _error  �� "0 exacterrorcheck ExactErrorCheck	� �~	��}�|	�	��{
�~ .ascrinit****      � ****	� k     	�	� ��z�z  �}  �|  	� �y�y  0 compareobjects compareObjects	� 	�	� �x��w�v	�	��u�x  0 compareobjects compareObjects�w �t	��t 	�  �s�r�s 0 expectederror expectedError�r 0 actualerror actualError�v  	� �q�p�o�n�m�l�q 0 expectederror expectedError�p 0 actualerror actualError�o 0 aref aRef�n $0 expectedproperty expectedProperty�m  0 actualproperty actualProperty�l 0 checkobject checkObject	� �k�j�i�h�g�f�e�d�c�b�a�`�k 0 errornumber errorNumber�j 0 errormessage errorMessage�i 0 	fromvalue 	fromValue�h 0 totype toType�g 0 partialresult partialResult�f 
�e 
kocl
�d 
cobj
�c .corecnte****       ****
�b 
pcnt�a 0 novalue NoValue�`  0 compareobjects compareObjects�u � ���,��,b  �,mv��,��,b  �,mv��,��,b  �,mv��,��,b  �,mv��,��,b  �,mv�v[��l kh ��,E[�k/E�Z[�l/E�Z[�m/E�ZO�b  �, ���l+ f  fY hY h[OY��Oe�{ L  �� s Rb  ��l+ E�O�b  �b  �b  �b  �b  �E�O��%E�O��,��, )�����Y hW X  *a ����a + Oa a K S�	l �_�  	��_ "0 exacterrorcheck ExactErrorCheck	� 	�	�	�	� 
 	�	�	�	��^�]�\�[	l	� �Z�Y�Z  �Y  	� �X	j	��X 0 errormessage errorMessage	� �W	j	��W 0 errornumber errorNumber	� �V	j	��V 0 	fromvalue 	fromValue	� �U	j	��U 0 totype toType	� �T	j�S�T 0 partialresult partialResult�S  �^  �]  �\  �[  	m �R0�Q�P	�	��O�R 20 _ascheckobjectparameter _asCheckObjectParameter�Q �N	��N 	�  �M�L�M 0 checkobject checkObject�L (0 defaultcheckobject defaultCheckObject�P  	� �K�J�K 0 checkobject checkObject�J (0 defaultcheckobject defaultCheckObject	� 
�IH�H�G�F�E�D�C�BX
�I 
msng�H &0 asscriptparameter asScriptParameter�G  0 compareobjects compareObjects�F 0 
hashandler 
hasHandler
�E 
errn�D�@
�C 
erob�B �O =��  �E�Y hOb  ��l+ E�Ob  ��,k+  )�����Y hO�	n �Ad�@�?	�	��>�A .0 _compareassertresults _compareAssertResults�@ �=	��= 	�  �<�;�:�9�8�< 0 checkobject checkObject�;  0 expectedresult expectedResult�: 0 actualresult actualResult�9 0 
assertname 
assertName�8 0 usernote userNote�?  	� 
�7�6�5�4�3�2�1�0�/�.�7 0 checkobject checkObject�6  0 expectedresult expectedResult�5 0 actualresult actualResult�4 0 
assertname 
assertName�3 0 usernote userNote�2 0 etext eText�1 0 enumber eNumber�0 0 efrom eFrom�/ 
0 eto eTo�. 0 epartial ePartial	� �-�,	����+�*�)�(�'�&�-  0 compareobjects compareObjects�, 0 etext eText	� �%�$	�
�% 
errn�$ 0 enumber eNumber	� �#�"	�
�# 
erob�" 0 efrom eFrom	� �!� 	�
�! 
errt�  
0 eto eTo	� ���
� 
ptlr� 0 epartial ePartial�  �+ �* .0 makecaughterrorrecord makeCaughtErrorRecord�) �( 0 	addbroken 	addBroken
�' 
errn
�& 
erob�> D ���l+  W 7X  b  	���b  ������+ lvkv�+ O)�b  �b  �h	o ����	�	��
� .���:AsRenull��� ��� null�  � ��	�
� 
Valu� 0 actualresult actualResult	� ��	�
� 
Equa�  0 expectedresult expectedResult	� �	�	�
� 
Summ	� {���� 0 usernote userNote�  	� �	��
� 
Usin	� {���� 0 checkobject checkObject�  
� 
msng�  	� ���
�	�������� 0 actualresult actualResult�  0 expectedresult expectedResult�
 0 usernote userNote�	 0 checkobject checkObject� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo� 0 epartial ePartial� 0 isequal isEqual� 0 testdata testData	� �� ������������	�����������3��@GV��dh��
� 
msng
�  
errn���T�� "0 astextparameter asTextParameter�� 20 _ascheckobjectparameter _asCheckObjectParameter�� 0 etext eText	� ����	�
�� 
errn�� 0 enumber eNumber	� ����
 
�� 
erob�� 0 efrom eFrom
  ����

�� 
errt�� 
0 eto eTo
 ������
�� 
ptlr�� 0 epartial ePartial��  �� �� .0 makecaughterrorrecord makeCaughtErrorRecord�� �� 0 	addbroken 	addBroken
�� 
erob�� .0 _compareassertresults _compareAssertResults�� 0 
addsuccess 
addSuccess�� 0 
addfailure 
addFailure� �b  �  )��l�Y hO�� �  b  ��l+ E�O*�b  l+ E�W =X 	 
b  	���b  ������+ lvkva + O)�b  a b  a hO*���a ��+ E�Oa �lva �lvlvE�O� b  	a ��m+ OhY *b  	a a ��a + O)�b  a b  a hV	p ��}����

��
�� .���:AsErnull��� ��� null��  �� ��


�� 
Hand
 {������� "0 callhandlername callHandlerName��  
 ��


�� 
Args
 {��������  0 parametervalue parameterValue��  
�� 
���!
 ����

�� 
Equa�� 0 expectederror expectedError
 ��
	


�� 
Summ
	 {������� 0 usernote userNote��  

 ��
��
�� 
Usin
 {�������� 0 checkobject checkObject��  
�� 
msng��  
 ���������������������������������� "0 callhandlername callHandlerName��  0 parametervalue parameterValue�� 0 expectederror expectedError�� 0 usernote userNote�� 0 checkobject checkObject�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo�� 0 epartial ePartial�� 0 
callobject 
callObject�� 0 actualerror actualError�� 0 actualresult actualResult�� 0 isequal isEqual�� 0 testdata testData�� 0 problemtype problemType
 0����������������������
������������#)2��?F��������������������
			0	:	H��
�� 
msng
�� 
errn���T�� "0 astextparameter asTextParameter�� &0 asrecordparameter asRecordParameter�� <0 normalizeexpectederrorrecord normalizeExpectedErrorRecord�� 20 _ascheckobjectparameter _asCheckObjectParameter�� 0 etext eText
 ����

�� 
errn�� 0 enumber eNumber
 ����

�� 
erob�� 0 efrom eFrom
 ����

�� 
errt�� 
0 eto eTo
 ������
�� 
ptlr�� 0 epartial ePartial��  �� �� .0 makecaughterrorrecord makeCaughtErrorRecord�� �� 0 	addbroken 	addBroken
�� 
erob
�� 
ctxt
�� 
���!��  0 makecallobject makeCallObject�� 0 novalue NoValue
�� 
cobj�� 0 dotest doTest�� .0 _compareassertresults _compareAssertResults�� 0 
addsuccess 
addSuccess��  
 ������
�� 
errn���?��  �� 0 
addfailure 
addFailure��Sb  �  )��l�Y hO��: Ib  ��l+ E�Ob  ��l+ 	E�Ob  �k+ 
E�Ob  ��l+ E�O*�b  l+ E�W CX  b  	�a �a b  �����a + lvkva + O)�b  a b  a hOga  ;�a   a b  
[a \[Za \Zi2%E�Y �a  a �%E�Y hVO�a   b  �jl+ E�Y b  �kl+ E�Ob  a ,b  a ,fmvE[a  k/E�Z[a  l/E�Z[a  m/E�ZO �b  �l+ !E�W *X  b  �����a + E�O*���a "�a + #E�Oa $�lvkvE�O� b  	a %��a &�lvkv%m+ 'OhY � �E�W X ( )b  a ,E�O�b  a , 'a *�a +�lvkv%lvE[a  k/E�Z[a  l/E�ZY hO�b  a , 'a ,�a -�lvkv%lvE[a  k/E�Z[a  l/E�ZY hOb  	a .���a + /O)�b  a b  a hVascr  ��ޭ