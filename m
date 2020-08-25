From: Li,Rongqing <lirongqing@baidu.com>
Date: Tue, 25 Aug 2020 09:55:24 +0000
Subject: [Intel-wired-lan] [PATCH net 3/3] ice: avoid premature Rx
 buffer reuse
In-Reply-To: <20200825091629.12949-4-bjorn.topel@gmail.com>
References: <20200825091629.12949-1-bjorn.topel@gmail.com>
 <20200825091629.12949-4-bjorn.topel@gmail.com>
Message-ID: <f4cf2c5e2a0a4a6bb877fb24f0cc8b97@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Bj?rn T?pel [mailto:bjorn.topel at gmail.com]
> Sent: Tuesday, August 25, 2020 5:16 PM
> To: jeffrey.t.kirsher at intel.com; intel-wired-lan at lists.osuosl.org
> Cc: Bj?rn T?pel <bjorn.topel@intel.com>; magnus.karlsson at intel.com;
> magnus.karlsson at gmail.com; netdev at vger.kernel.org;
> maciej.fijalkowski at intel.com; piotr.raczynski at intel.com;
> maciej.machnikowski at intel.com; Li,Rongqing <lirongqing@baidu.com>
> Subject: [PATCH net 3/3] ice: avoid premature Rx buffer reuse
> 
> From: Bj?rn T?pel <bjorn.topel@intel.com>
> 
> The page recycle code, incorrectly, relied on that a page fragment could not be
> freed inside xdp_do_redirect(). This assumption leads to that page fragments
> that are used by the stack/XDP redirect can be reused and overwritten.
> 
> To avoid this, store the page count prior invoking xdp_do_redirect().
> 
> Fixes: efc2214b6047 ("ice: Add support for XDP")
> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>


Reported-and-analyzed-by: Li RongQing <lirongqing@baidu.com>

Thanks

-Li

