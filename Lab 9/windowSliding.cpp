
#include <iostream>
using namespace std;

// int i = 0;
// int slidingWindow(int arr[i], int windowsize)
// {
//   if (arr.size() <= windowsize)
//   {
//     return arr;
//   }

//   for (i = 0; arr[i] >= windowsize; i++)
//   {
//     cout << arr [i:i + windowsize];
//   }
// }

// int main()
// {

//   int arr[8] = {1, 2, 3, 4, 5, 6, 7, 8};
//   slidingWindow(arr, 3);
//   return 0;
// }

int maxSum(int arr[], int n, int k)
{

  if (n < k)
  {
    cout << "Invalid";
    return -1;
  }

  int window_sum = 0;
  for (int i = 0; i < k; i++)
    window_sum += arr[i];

  int max_sum = window_sum;
  for (int i = k; i < n; i++)
  {
    window_sum += (arr[i] - arr[i - k]);
    max_sum = max(max_sum, window_sum);
  }
  return max_sum;
}

int main()
{
  int n = 5, k = 3;
  ;
  int arr[] = {16, 12, 9, 19, 11, 8};
  cout << maxSum(arr, n, k);
  return 0;
}