From: David Miller <davem@davemloft.net>
Date: Tue, 16 Jul 2019 14:19:04 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH net-next v1] fix: taprio: Change type
 of txtime-delay parameter to u32
In-Reply-To: <1563306738-2779-1-git-send-email-vedang.patel@intel.com>
References: <1563306738-2779-1-git-send-email-vedang.patel@intel.com>
Message-ID: <20190716.141904.308520366333461345.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Vedang Patel <vedang.patel@intel.com>
Date: Tue, 16 Jul 2019 12:52:18 -0700

> During the review of the iproute2 patches for txtime-assist mode, it was
> pointed out that it does not make sense for the txtime-delay parameter to
> be negative. So, change the type of the parameter from s32 to u32.
> 
> Fixes: 4cfd5779bd6e ("taprio: Add support for txtime-assist mode")
> Reported-by: Stephen Hemminger <stephen@networkplumber.org>
> Signed-off-by: Vedang Patel <vedang.patel@intel.com>

You should have targetted this at 'net' as that's the only tree open
right now.

I'll apply this.
