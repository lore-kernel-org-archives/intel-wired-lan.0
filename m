From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@intel.com>
Date: Tue, 25 Aug 2020 12:00:33 +0200
Subject: [Intel-wired-lan] [PATCH net 2/3] ixgbe: avoid premature Rx
 buffer reuse
In-Reply-To: <6356c0ddbdbd4f8fb4927f3ee96c4c33@baidu.com>
References: <20200825091629.12949-1-bjorn.topel@gmail.com>
 <20200825091629.12949-3-bjorn.topel@gmail.com>
 <6356c0ddbdbd4f8fb4927f3ee96c4c33@baidu.com>
Message-ID: <43f838aa-b12b-63d3-400b-ef92081b355d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2020-08-25 11:55, Li,Rongqing wrote:
> 
> 
>> -----Original Message-----
>> From: Bj?rn T?pel [mailto:bjorn.topel at gmail.com]
>> Sent: Tuesday, August 25, 2020 5:16 PM
>> To: jeffrey.t.kirsher at intel.com; intel-wired-lan at lists.osuosl.org
>> Cc: Bj?rn T?pel <bjorn.topel@intel.com>; magnus.karlsson at intel.com;
>> magnus.karlsson at gmail.com; netdev at vger.kernel.org;
>> maciej.fijalkowski at intel.com; piotr.raczynski at intel.com;
>> maciej.machnikowski at intel.com; Li,Rongqing <lirongqing@baidu.com>
>> Subject: [PATCH net 2/3] ixgbe: avoid premature Rx buffer reuse
>>
>> From: Bj?rn T?pel <bjorn.topel@intel.com>
>>
>> The page recycle code, incorrectly, relied on that a page fragment could not be
>> freed inside xdp_do_redirect(). This assumption leads to that page fragments
>> that are used by the stack/XDP redirect can be reused and overwritten.
>>
>> To avoid this, store the page count prior invoking xdp_do_redirect().
>>
>> Fixes: 6453073987ba ("ixgbe: add initial support for xdp redirect")
>> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
> 
> Reported-and-analyzed-by: Li RongQing <lirongqing@baidu.com>
>

Thanks Li! I should have added that. Intel-folks, please make sure Li's 
tags for ixgbe/ice are added.


Bj?rn


> Thanks
> 
> -Li
> 
