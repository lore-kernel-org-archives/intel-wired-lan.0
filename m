From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@intel.com>
Date: Wed, 19 Aug 2020 10:52:40 +0200
Subject: [Intel-wired-lan] 
 =?utf-8?b?562U5aSNOiDnrZTlpI06ICBbUEFUQ0ggMC8y?=
 =?utf-8?q?=5D_intel/xdp_fixes_for_fliping_rx_buffer?=
In-Reply-To: <c691e3d2-8b16-744c-8918-5be042bd37dc@intel.com>
References: <1594967062-20674-1-git-send-email-lirongqing@baidu.com>
 <CAJ+HfNi2B+2KYP9A7yCfFUhfUBd=sFPeuGbNZMjhNSdq3GEpMg@mail.gmail.com>
 <4268316b200049d58b9973ec4dc4725c@baidu.com>
 <83e45ec2-1c66-59f6-e817-d4c523879007@intel.com>
 <c3695fc71ca140d08a795bbd32d8522f@baidu.com>
 <c691e3d2-8b16-744c-8918-5be042bd37dc@intel.com>
Message-ID: <7d5ec101-b14c-ffda-053b-8a1ab46bf265@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2020-08-19 10:31, Bj?rn T?pel wrote:
[...]
> 
> But please, try to reproduce with a newer kernel.
>

Also, you are *sure* that you're touching stale data? Have you tried 
running with CONFIG_DEBUG_PAGEALLOC and CONFIG_PAGE_POISONING?


Bj?rn
