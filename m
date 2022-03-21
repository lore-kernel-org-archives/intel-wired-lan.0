From: Jiabing Wan <wanjiabing@vivo.com>
Date: Mon, 21 Mar 2022 20:02:53 +0800
Subject: [Intel-wired-lan] [PATCH] ice: use min() to make code cleaner
 in ice_gnss
In-Reply-To: <20220321115412.844440-1-alexandr.lobakin@intel.com>
References: <20220318094629.526321-1-wanjiabing@vivo.com>
 <8822dfa2-bdb8-fceb-e920-94afb50881e8@intel.com>
 <20220321115412.844440-1-alexandr.lobakin@intel.com>
Message-ID: <cf2dd88b-908d-efbb-9d5d-7194e2ed43ba@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 2022/3/21 19:54, Alexander Lobakin wrote:
> From: Tony Nguyen <anthony.l.nguyen@intel.com>
> Date: Fri, 18 Mar 2022 13:19:26 -0700
>
>> On 3/18/2022 2:46 AM, Wan Jiabing wrote:
> Hey Wan,
>
>>> Fix the following coccicheck warning:
>>> ./drivers/net/ethernet/intel/ice/ice_gnss.c:79:26-27: WARNING opportunity for min()
>>>
>>> Use min() to make code cleaner.
>>>
>>> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
>> There are build issues with this patch:
>>
>> In file included from ./include/linux/kernel.h:26,
>>                   from drivers/net/ethernet/intel/ice/ice.h:9,
>>                   from drivers/net/ethernet/intel/ice/ice_gnss.c:4:
>> drivers/net/ethernet/intel/ice/ice_gnss.c: In function 'ice_gnss_read':
>> ./include/linux/minmax.h:20:35: error: comparison of distinct pointer types lacks a cast [-Werror]
>>     20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
>>        |                                   ^~
>> ./include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
>>     26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
>>        |                  ^~~~~~~~~~~
>> ./include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
>>     36 |         __builtin_choose_expr(__safe_cmp(x, y), \
>>        |                               ^~~~~~~~~~
>> ./include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
>>     45 | #define min(x, y)       __careful_cmp(x, y, <)
>>        |                         ^~~~~~~~~~~~~
>> drivers/net/ethernet/intel/ice/ice_gnss.c:79:30: note: in expansion of macro 'min'
>>     79 |                 bytes_read = min(bytes_left, ICE_MAX_I2C_DATA_SIZE);
>>        |                              ^~~
> Use `min_t(typeof(bytes_left), ICE_MAX_I2C_DATA_SIZE)` to avoid
> this. Plain definitions are usually treated as `unsigned long`
> unless there's a suffix (u, ull etc.).
>
>> cc1: all warnings being treated as errors
> Thanks,
> Al

OK, I'll fix it in v2.

Thanks,
Wan Jiabing

