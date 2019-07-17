From: Patel, Vedang <vedang.patel@intel.com>
Date: Wed, 17 Jul 2019 17:32:10 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1] fix: taprio: Change type
 of txtime-delay parameter to u32
In-Reply-To: <20190716.141904.308520366333461345.davem@davemloft.net>
References: <1563306738-2779-1-git-send-email-vedang.patel@intel.com>
 <20190716.141904.308520366333461345.davem@davemloft.net>
Message-ID: <D18998A5-4B08-4F27-897F-A34B7C15684F@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> On Jul 16, 2019, at 2:19 PM, David Miller <davem@davemloft.net> wrote:
> 
> From: Vedang Patel <vedang.patel@intel.com>
> Date: Tue, 16 Jul 2019 12:52:18 -0700
> 
>> During the review of the iproute2 patches for txtime-assist mode, it was
>> pointed out that it does not make sense for the txtime-delay parameter to
>> be negative. So, change the type of the parameter from s32 to u32.
>> 
>> Fixes: 4cfd5779bd6e ("taprio: Add support for txtime-assist mode")
>> Reported-by: Stephen Hemminger <stephen@networkplumber.org>
>> Signed-off-by: Vedang Patel <vedang.patel@intel.com>
> 
> You should have targetted this at 'net' as that's the only tree open
> right now.
> 
> I'll apply this.

Sorry about that.

I will keep this in mind from next time. 

Thanks,
Vedang
