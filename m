From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@intel.com>
Date: Tue, 25 Aug 2020 19:14:09 +0200
Subject: [Intel-wired-lan] [PATCH net v2 3/3] ice: avoid premature Rx
 buffer reuse
In-Reply-To: <20200825084959.69e0bb0d@kicinski-fedora-PC1C0HJN>
References: <20200825121323.20239-1-bjorn.topel@gmail.com>
 <20200825121323.20239-4-bjorn.topel@gmail.com>
 <20200825084959.69e0bb0d@kicinski-fedora-PC1C0HJN>
Message-ID: <9590fe12-55a5-69fd-0737-32a6c9aceca3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2020-08-25 17:49, Jakub Kicinski wrote:
> On Tue, 25 Aug 2020 14:13:23 +0200 Bj?rn T?pel wrote:
>> From: Bj?rn T?pel <bjorn.topel@intel.com>
>>
>> The page recycle code, incorrectly, relied on that a page fragment
>> could not be freed inside xdp_do_redirect(). This assumption leads to
>> that page fragments that are used by the stack/XDP redirect can be
>> reused and overwritten.
>>
>> To avoid this, store the page count prior invoking xdp_do_redirect().
>>
>> Fixes: efc2214b6047 ("ice: Add support for XDP")
>> Reported-and-analyzed-by: Li RongQing <lirongqing@baidu.com>
>> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
> 
> Gotta adjust the kdoc:
> 
> drivers/net/ethernet/intel/ice/ice_txrx.c:773: warning: Function parameter or member 'rx_buf_pgcnt' not described in 'ice_can_reuse_rx_page'
> drivers/net/ethernet/intel/ice/ice_txrx.c:885: warning: Function parameter or member 'rx_buf_pgcnt' not described in 'ice_get_rx_buf'
> drivers/net/ethernet/intel/ice/ice_txrx.c:1033: warning: Function parameter or member 'rx_buf_pgcnt' not described in 'ice_put_rx_buf'
> 

Thanks! I'll spin a v3.
