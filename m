From: Tantilov, Emil S <emil.s.tantilov@intel.com>
Date: Mon, 19 Sep 2016 16:57:37 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: mark symbols static where
	possible
In-Reply-To: <1474188454-8872-1-git-send-email-baoyou.xie@linaro.org>
References: <1474188454-8872-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <87618083B2453E4A8714035B62D67992506E6E36@FMSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


>-----Original Message-----
From: netdev-owner@vger.kernel.org [mailto:netdev-owner at vger.kernel.org] On
>Behalf Of Baoyou Xie
>Sent: Sunday, September 18, 2016 1:48 AM
>To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
>lan at lists.osuosl.org
>Cc: netdev at vger.kernel.org; linux-kernel at vger.kernel.org; arnd at arndb.de;
>baoyou.xie at linaro.org; xie.baoyou at zte.com.cn
>Subject: [PATCH] ixgbe: mark symbols static where possible
>
>We get 2 warnings when building kernel with W=1:
>drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:2128:5: warning: no previous
>prototype for 'ixgbe_led_on_t_x550em' [-Wmissing-prototypes]
>drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:2150:5: warning: no previous
>prototype for 'ixgbe_led_off_t_x550em' [-Wmissing-prototypes]

Already taken care of:
http://patchwork.ozlabs.org/patch/661647/

Thanks,
Emil

