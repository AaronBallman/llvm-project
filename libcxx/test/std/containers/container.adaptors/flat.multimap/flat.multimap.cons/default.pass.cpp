//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

// UNSUPPORTED: c++03, c++11, c++14, c++17, c++20

// <flat_map>

// flat_multimap();

#include <cassert>
#include <deque>
#include <flat_map>
#include <functional>
#include <type_traits>
#include <vector>

#include "test_macros.h"
#include "min_allocator.h"
#include "test_allocator.h"

struct DefaultCtableComp {
  constexpr explicit DefaultCtableComp() { default_constructed_ = true; }
  constexpr bool operator()(int, int) const { return false; }
  bool default_constructed_ = false;
};

template <template <class...> class KeyContainer, template <class...> class ValueContainer>
constexpr void test() {
  {
    std::flat_multimap<int, char*, std::less<int>, KeyContainer<int>, ValueContainer<char*>> m;
    assert(m.empty());
  }
  {
    // explicit(false)
    std::flat_multimap<int, char*, std::less<int>, KeyContainer<int>, ValueContainer<char*>> m = {};
    assert(m.empty());
  }
  {
    std::flat_multimap<int, char*, DefaultCtableComp, KeyContainer<int, min_allocator<int>>> m;
    assert(m.empty());
    assert(m.begin() == m.end());
    assert(m.key_comp().default_constructed_);
  }
  {
    using A1 = explicit_allocator<int>;
    using A2 = explicit_allocator<char*>;
    {
      std::flat_multimap<int, char*, DefaultCtableComp, KeyContainer<int, A1>, ValueContainer<char*, A2>> m;
      assert(m.empty());
      assert(m.key_comp().default_constructed_);
    }
    {
      A1 a1;
      std::flat_multimap<int, int, DefaultCtableComp, KeyContainer<int, A1>, ValueContainer<int, A1>> m(a1);
      assert(m.empty());
      assert(m.key_comp().default_constructed_);
    }
  }
  {
    // If an allocator is given, it must be usable by both containers.
    using A = test_allocator<int>;
    using M = std::flat_multimap<int, int, std::less<>, KeyContainer<int>, ValueContainer<int, A>>;
    static_assert(std::is_constructible_v<M>);
    static_assert(!std::is_constructible_v<M, std::allocator<int>>);
    static_assert(!std::is_constructible_v<M, A>);
  }
}

constexpr bool test() {
  test<std::vector, std::vector>();

#ifndef __cpp_lib_constexpr_deque
  if (!TEST_IS_CONSTANT_EVALUATED)
#endif
  {
    test<std::deque, std::deque>();
  }

  return true;
}

int main(int, char**) {
  test();
#if TEST_STD_VER >= 26
  static_assert(test());
#endif

  return 0;
}
