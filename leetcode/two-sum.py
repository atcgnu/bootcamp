#https://leetcode-cn.com/problems/two-sum/
class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        e_dict = {}
        for i, element in enumerate(nums):
            e_dict[element] = i
            
        for i, element in enumerate(nums):
            e2 = target - element
            r = e_dict.get(e2, 'next')
            if(r != 'next' and i != e_dict[e2]):
                return [i, e_dict[e2]]
