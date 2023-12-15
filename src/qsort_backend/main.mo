import Array "mo:base/Array";
import Iter "mo:base/Iter";

actor {
   func quicksort(arr: [var Int]): () {
    func partition(low: Nat, high: Nat): Nat {
        let pivot = arr[high];
        var i = low;
        for (j in Iter.range(low, high)) {
            if (arr[j] < pivot) {
                let temp = arr[i];
                arr[i] := arr[j];
                arr[j] := temp;
                i += 1;
            };
        };
        arr[high] := arr[i];
        arr[i] := pivot;
        return i;
    };

    func sort(low: Nat, high: Nat): () {
        if (low < high) {
            let pi = partition(low, high);
            if (pi > 0) {
              sort(low, pi - 1);
            };
            sort(pi + 1, high);
        };
    };

    if (arr.size() > 0) {
        sort(0, arr.size() - 1);
    };
};

public func qsort(arr: [Int]): async [Int] {
    // 将不可变数组转换为可变数组
    let mutableArr: [var Int] = Array.thaw(arr);

    // 对可变数组进行排序
    quicksort(mutableArr);

    // 将可变数组转换回不可变数组并返回
    return Array.freeze(mutableArr);
};

};
