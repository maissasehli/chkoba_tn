import 'package:chkoba_tn/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ChkobaLoginPage extends StatefulWidget {
  const ChkobaLoginPage({Key? key}) : super(key: key);

  @override
  State<ChkobaLoginPage> createState() => _ChkobaLoginPageState();
}

class _ChkobaLoginPageState extends State<ChkobaLoginPage>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late AnimationController _cardController;
  late AnimationController _shimmerController;

  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _cardAnimation;
  late Animation<double> _shimmerAnimation;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _startAnimations();
  }

  void _initAnimations() {
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _cardController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _shimmerController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutQuart,
    ));

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );

    _cardAnimation = CurvedAnimation(
      parent: _cardController,
      curve: Curves.easeInOut,
    );

    _shimmerAnimation = CurvedAnimation(
      parent: _shimmerController,
      curve: Curves.easeInOut,
    );
  }

  void _startAnimations() {
    Future.delayed(const Duration(milliseconds: 200), () {
      _slideController.forward();
      _fadeController.forward();
    });
    _cardController.repeat();
    _shimmerController.repeat();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    _cardController.dispose();
    _shimmerController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _usernameFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      _showErrorSnackBar('Veuillez remplir tous les champs');
      return;
    }

    setState(() {
      _isLoading = true;
      Navigator.pushReplacement(
  context, 
  MaterialPageRoute(builder: (context) => const ChkobaHomePage())
);
    });

    // Simulation d'une connexion
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    // Navigation vers la page principale du jeu
    _showSuccessSnackBar('Connexion réussie!');
    
    // Ici vous pouvez naviguer vers votre page principale
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChkobaGamePage()));
  }

  Future<void> _handleSocialLogin(String provider) async {
    _showErrorSnackBar('Connexion avec $provider en cours de développement');
    // Ici vous pouvez implémenter la logique de connexion sociale
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFFE31E24),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE31E24), // Rouge tunisien
              Color(0xFFC41E3A),
              Color(0xFF8B0000), // Rouge plus foncé
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Éléments décoratifs de fond
              ..._buildBackgroundDecorations(),
              
              // Contenu principal
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Logo avec cartes animées
                          _buildAnimatedLogo(),
                          
                          const SizedBox(height: 40),
                          
                          // Carte de connexion
                          _buildLoginCard(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildBackgroundDecorations() {
    return [
      // Motifs tunisiens décoratifs
      Positioned(
        top: 60,
        left: 30,
        child: AnimatedBuilder(
          animation: _shimmerController,
          builder: (context, child) {
            return Transform.rotate(
              angle: _shimmerController.value * 2 * math.pi,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0x22FFD700),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: const Color(0x44FFD700),
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.star,
                  color: Color(0x66FFD700),
                  size: 30,
                ),
              ),
            );
          },
        ),
      ),
      
      Positioned(
        top: 120,
        right: 40,
        child: AnimatedBuilder(
          animation: _cardController,
          builder: (context, child) {
            return Transform.scale(
              scale: 1 + 0.1 * math.sin(_cardController.value * 2 * math.pi),
              child: Container(
                width: 30,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: const Color(0x44FFD700),
                    width: 1,
                  ),
                ),
                child: const Center(
                  child: Text(
                    '♦',
                    style: TextStyle(
                      color: Color(0x88FFD700),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      
      Positioned(
        bottom: 100,
        left: 50,
        child: AnimatedBuilder(
          animation: _shimmerController,
          builder: (context, child) {
            return Transform.rotate(
              angle: -_shimmerController.value * 2 * math.pi,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      const Color(0x44FFD700),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: const Icon(
                  Icons.brightness_1,
                  color: Color(0x33FFD700),
                  size: 20,
                ),
              ),
            );
          },
        ),
      ),
    ];
  }

  Widget _buildAnimatedLogo() {
    return Column(
      children: [
        // Cartes animées miniatures
        SizedBox(
          width: 80,
          height: 60,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedBuilder(
                animation: _cardAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(
                      -10 + 2 * math.sin(_cardAnimation.value * 2 * math.pi),
                      2 * math.sin(_cardAnimation.value * 2 * math.pi + 1),
                    ),
                    child: _buildMiniCard('♥', const Color(0xFFE31E24)),
                  );
                },
              ),
              AnimatedBuilder(
                animation: _cardAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(
                      10 + 2 * math.sin(_cardAnimation.value * 2 * math.pi + 2),
                      2 * math.sin(_cardAnimation.value * 2 * math.pi + 3),
                    ),
                    child: _buildMiniCard('♦', const Color(0xFFFFD700)),
                  );
                },
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 20),
        
        // Titre
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.white, Color(0xFFFFD700), Colors.white],
          ).createShader(bounds),
          child: const Text(
            'CHKOBA',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 2,
              shadows: [
                Shadow(
                  offset: Offset(2, 2),
                  blurRadius: 8,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 8),
        
        const Text(
          'Connexion',
          style: TextStyle(
            fontSize: 18,
            color: Color(0xFFFFD700),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildMiniCard(String symbol, Color color) {
    return Container(
      width: 30,
      height: 42,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Center(
        child: Text(
          symbol,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginCard() {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 400),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(0, 8),
            blurRadius: 24,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Boutons de connexion sociale
          _buildSocialLoginButtons(),
          
          const SizedBox(height: 24),
          
          // Séparateur "OU"
          _buildDivider(),
          
          const SizedBox(height: 24),
          
          // Champ nom d'utilisateur
          _buildTextField(
            controller: _usernameController,
            focusNode: _usernameFocus,
            label: 'Nom d\'utilisateur',
            icon: Icons.person_outline,
            textInputAction: TextInputAction.next,
            onSubmitted: (_) => _passwordFocus.requestFocus(),
          ),
          
          const SizedBox(height: 20),
          
          // Champ mot de passe
          _buildTextField(
            controller: _passwordController,
            focusNode: _passwordFocus,
            label: 'Mot de passe',
            icon: Icons.lock_outline,
            isPassword: true,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _handleLogin(),
          ),
          
          const SizedBox(height: 32),
          
          // Bouton de connexion
          _buildLoginButton(),
          
          const SizedBox(height: 20),
          
          // Liens additionnels
          _buildAdditionalLinks(),
        ],
      ),
    );
  }

  Widget _buildSocialLoginButtons() {
    return Column(
      children: [
        // Bouton Facebook
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton.icon(
            onPressed: () => _handleSocialLogin('Facebook'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1877F2),
              foregroundColor: Colors.white,
              elevation: 4,
              shadowColor: const Color(0xFF1877F2).withOpacity(0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Center(
                child: Text(
                  'f',
                  style: TextStyle(
                    color: Color(0xFF1877F2),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            label: const Text(
              'Continuer avec Facebook',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        
        const SizedBox(height: 12),
        
        // Bouton Google
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton.icon(
            onPressed: () => _handleSocialLogin('Google'),
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black87,
              side: BorderSide(color: Colors.grey.shade300, width: 1),
              elevation: 2,
              shadowColor: Colors.black12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.network(
                'https://developers.google.com/identity/images/g-logo.png',
                width: 20,
                height: 20,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'G',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            label: const Text(
              'Continuer avec Google',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: Colors.grey.shade300,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'OU',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: Colors.grey.shade300,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required IconData icon,
    bool isPassword = false,
    TextInputAction? textInputAction,
    Function(String)? onSubmitted,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: focusNode.hasFocus
            ? [
                BoxShadow(
                  color: const Color(0xFFE31E24).withOpacity(0.2),
                  offset: const Offset(0, 2),
                  blurRadius: 8,
                ),
              ]
            : [],
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        obscureText: isPassword && !_isPasswordVisible,
        textInputAction: textInputAction,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(
            icon,
            color: focusNode.hasFocus ? const Color(0xFFE31E24) : Colors.grey[600],
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey[600],
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                )
              : null,
          filled: true,
          fillColor: Colors.grey[50],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFFE31E24),
              width: 2,
            ),
          ),
          labelStyle: TextStyle(
            color: focusNode.hasFocus ? const Color(0xFFE31E24) : Colors.grey[600],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleLogin,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE31E24),
          foregroundColor: Colors.white,
          elevation: 8,
          shadowColor: const Color(0xFFE31E24).withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Text(
                'Se Connecter',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
      ),
    );
  }

  Widget _buildAdditionalLinks() {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            // Action pour mot de passe oublié
            _showErrorSnackBar('Fonctionnalité en cours de développement');
          },
          child: const Text(
            'Mot de passe oublié ?',
            style: TextStyle(
              color: Color(0xFFE31E24),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        
        const SizedBox(height: 8),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Nouveau joueur ? ',
              style: TextStyle(color: Colors.grey),
            ),
            TextButton(
              onPressed: () {
                // Action pour créer un compte
                _showErrorSnackBar('Fonctionnalité en cours de développement');
              },
              child: const Text(
                'Créer un compte',
                style: TextStyle(
                  color: Color(0xFFE31E24),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}