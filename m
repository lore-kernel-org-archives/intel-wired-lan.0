From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Tue, 8 Sep 2020 12:12:30 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 4/4] ixgbe,
 xsk: use XSK_NAPI_WEIGHT as NAPI poll budget
In-Reply-To: <20200907150217.30888-5-bjorn.topel@gmail.com>
References: <20200907150217.30888-1-bjorn.topel@gmail.com>
 <20200907150217.30888-5-bjorn.topel@gmail.com>
Message-ID: <82901368-8e17-a63d-0e46-2434b5777c04@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Bj?rn,


Am 07.09.20 um 17:02 schrieb Bj?rn T?pel:
> From: Bj?rn T?pel <bjorn.topel@intel.com>
> 
> Start using XSK_NAPI_WEIGHT as NAPI poll budget for the AF_XDP Rx
> zero-copy path.

Could you please add the description from the patch series cover letter 
to this commit too? To my knowledge, the message in the cover letter 
won?t be stored in the git repository.

> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

[?]


Kind regards,

Paul
