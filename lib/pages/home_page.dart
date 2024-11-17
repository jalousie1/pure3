import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Add this extension at the top of the file, after the imports
extension ListSpaceBetweenExtension on List<Widget> {
  List<Widget> divide(Widget separator) {
    if (length <= 1) return this;
    
    final List<Widget> result = [];
    for (int i = 0; i < length - 1; i++) {
      result.add(this[i]);
      result.add(separator);
    }
    result.add(last);
    return result;
  }
}

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String _userName = '';

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());
    _loadUserName();
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  Future<void> _loadUserName() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userData = await FirebaseFirestore.instance
            .collection('usuarios')  // Changed from 'users' to 'usuarios'
            .doc(user.uid)
            .get();
        
        if (userData.exists && mounted) {
          setState(() {
            _userName = userData.get('name') ?? ''; // Changed from 'fullName' to 'name'
          });
        }
      }
    } catch (e) {
      debugPrint('Error loading user name: $e');
    }
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  void safeSetState(Function() update) => setState(() {
    if (mounted) update();
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header section
            Material(
              color: Colors.transparent,
              elevation: 4.0,
              child: Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: 120.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primary,
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 16.0, 24.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'PureLife',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontFamily: 'Urbanist',
                          color: FlutterFlowTheme.of(context).info,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      FlutterFlowIconButton(
                        borderRadius: 24.0,
                        buttonSize: 48.0,
                        fillColor: const Color(0x33FFFFFF),
                        icon: Icon(
                          Icons.account_circle,
                          color: FlutterFlowTheme.of(context).info,
                          size: 28.0,
                        ),
                        onPressed: () async {
                          context.pushNamed('/profile'); // Changed from 'profile' to '/profile'
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Content section
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Welcome text
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text(
                        'Welcome back${_userName.isNotEmpty ? ", $_userName" : ""}!',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontFamily: 'Manrope',
                        ),
                      ),
                    ),

                    // Chat button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: FFButtonWidget(
                        onPressed: () => context.pushNamed('/chatbot'),
                        text: 'Chat with MindBot',
                        icon: Icon(
                          Icons.chat,
                          color: FlutterFlowTheme.of(context).info,
                          size: 15.0,
                        ),
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 56.0,
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,  // Changed this line
                            fontFamily: 'Manrope',
                          ),
                          elevation: 2.0,
                          borderRadius: BorderRadius.circular(28.0),
                        ),
                      ),
                    ),

                    // Health News section
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text(
                        'Health News',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontFamily: 'Urbanist',
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    // News Cards
                    SizedBox(
                      height: 200.0, // Reduced height from 220 to 200
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildNewsCard(
                            context,
                            'The Benefits of Mediterranean Diet',
                            'New study reveals long-term health benefits',
                            'https://images.unsplash.com/photo-1514995669114-6081e934b693?w=500&h=500',
                          ),
                          const SizedBox(width: 16),
                          _buildNewsCard(
                            context,
                            'Mindfulness and Stress Reduction',
                            'How daily meditation can improve mental health',
                            'https://images.unsplash.com/photo-1523681504355-8b4860f99a58?w=500&h=500',
                          ),
                          const SizedBox(width: 16),
                          _buildNewsCard(
                            context,
                            'The Power of High-Intensity Workouts',
                            'Maximize your fitness results in less time',
                            'https://images.unsplash.com/photo-1483721310020-03333e577078?w=500&h=500',
                          ),
                        ],
                      ),
                    ),

                    // Daily Health Tip
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Material(
                        color: Colors.transparent,
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).primaryBackground,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.lightbulb_outline,
                                      color: FlutterFlowTheme.of(context).primary,
                                      size: 28.0,
                                    ),
                                    Text(
                                      'Tip of the Day',
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16.0),
                                Text(
                                  'Stay hydrated! Aim to drink at least 8 glasses of water daily. Proper hydration supports overall health, improves energy levels, and aids in digestion.',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Progress section
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Material(
                        color: Colors.transparent,
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).primaryBackground,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Daily Step Goal',
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        fontFamily: 'Manrope',
                                        color: FlutterFlowTheme.of(context).primaryText,
                                        letterSpacing: 0.0,
                                      ),
                                    ),
                                    Text(
                                      '${_model.sliderValue?.toInt() ?? 0} / 10,000',
                                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                        fontFamily: 'Manrope',
                                        color: FlutterFlowTheme.of(context).secondaryText,
                                        letterSpacing: 0.0,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Slider(
                                    activeColor: FlutterFlowTheme.of(context).primary,
                                    inactiveColor: const Color(0xFFE0E3E7),
                                    min: 0.0,
                                    max: 10000.0,
                                    value: _model.sliderValue ??= 7500.0,
                                    onChanged: (newValue) {
                                      newValue = double.parse(newValue.toStringAsFixed(4));
                                      setState(() => _model.sliderValue = newValue);
                                    },
                                  ),
                                ),
                              ].divide(const SizedBox(height: 16.0)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ].divide(const SizedBox(height: 24.0)),
                ),
              ),
            ),
          ],
          ),
        ),
      );
    }
  }

  Widget _buildNewsCard(BuildContext context, String title, String subtitle, String imageUrl) {
    return Material(
      color: Colors.transparent,
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        width: 300.0,
        constraints: const BoxConstraints(
          maxHeight: 220.0, // Add constraint instead of fixed height
        ),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Keep this
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(  // Wrap image in Flexible
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
                child: Image.network(
                  imageUrl,
                  width: 300.0,
                  height: 120.0, // Reduced height
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0), // Reduced padding
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1, // Limit lines
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4.0), // Reduced spacing
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 2, // Limit lines
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }