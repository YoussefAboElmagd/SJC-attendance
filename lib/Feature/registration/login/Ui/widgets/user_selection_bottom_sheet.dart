import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/helpers/cache_helper.dart';
import 'package:madarj/Core/themes/styles.dart';

class UserSelectionBottomSheet extends StatefulWidget {
  final Function(String email, String password) onUserSelected;
  final Function() onAddNewUser;

  const UserSelectionBottomSheet({
    super.key,
    required this.onUserSelected,
    required this.onAddNewUser,
  });

  @override
  State<UserSelectionBottomSheet> createState() =>
      _UserSelectionBottomSheetState();
}

class _UserSelectionBottomSheetState extends State<UserSelectionBottomSheet> {
  List<Map<String, String>> _savedUsers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSavedUsers();
  }

  Future<void> _loadSavedUsers() async {
    try {
      final users = await CacheHelper.getSavedUsers();
      setState(() {
        _savedUsers = users;
        _isLoading = false;
      });
    } catch (e) {
      // debugPrint('Error loading saved users: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteUser(int index) async {
    try {
      final userEmail = _savedUsers[index]['email']!;
      await CacheHelper.removeUser(userEmail);
      await _loadSavedUsers(); // Reload the list

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User $userEmail removed'),
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      // debugPrint('Error deleting user: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error removing user'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showDeleteConfirmation(int index) {
    final userEmail = _savedUsers[index]['email']!;
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Remove User'),
            content: Text('Are you sure you want to remove $userEmail?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _deleteUser(index);
                },
                child: const Text(
                  'Remove',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            margin: EdgeInsets.symmetric(vertical: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
            child: Row(
              children: [
                Text('Saved Users', style: TextStyles.font20BlackBold),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close, size: 24),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          Divider(height: 1.h, thickness: 1),

          // Content
          Expanded(
            child:
                _isLoading
                    ? _buildLoadingIndicator()
                    : _savedUsers.isEmpty
                    ? _buildEmptyState()
                    : _buildUsersList(),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.people_outline, size: 64.w, color: Colors.grey[400]),
          SizedBox(height: 16.h),
          Text('No Saved Users', style: TextStyles.font18BlackSemiBold),
          SizedBox(height: 8.h),
          Text(
            'Login with "Remember Me" to save users for faster access',
            textAlign: TextAlign.center,
            style: TextStyles.font14GreyRegular,
          ),
        ],
      ),
    );
  }

  Widget _buildUsersList() {
    return Column(
      children: [
        // Users list
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            itemCount: _savedUsers.length,
            itemBuilder: (context, index) {
              final user = _savedUsers[index];
              return _buildUserItem(user, index);
            },
          ),
        ),

        // Add new user button
        Padding(
          padding: EdgeInsets.all(16.w),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                widget.onAddNewUser();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.blue,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  side: BorderSide(color: Colors.blue, width: 1.w),
                ),
                padding: EdgeInsets.symmetric(vertical: 16.h),
              ),
              child: Text('Add New User', style: TextStyles.font16BlueSemiBold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserItem(Map<String, String> user, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(
            user['email']!.substring(0, 1).toUpperCase(),
            style: TextStyles.font16WhiteSemiBold.copyWith(color: Colors.blue),
          ),
        ),
        title: Text(user['email']!, style: TextStyles.font16BlackSemiBold),
        // subtitle: Text(
        //   user['email']!,
        //   style: TextStyles.font14GreyRegular,
        //   overflow: TextOverflow.ellipsis,
        // ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.delete_outline, size: 20.w, color: Colors.grey),
              onPressed: () => _showDeleteConfirmation(index),
            ),
            Icon(Icons.chevron_right, size: 20.w, color: Colors.grey),
          ],
        ),
        onTap: () {
          Navigator.pop(context);
          widget.onUserSelected(user['email']!, user['password']!);
        },
      ),
    );
  }
}
