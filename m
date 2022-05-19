From: naamax.meir <naamax.meir@linux.intel.com>
Date: Thu, 19 May 2022 12:51:11 +0300
Subject: [Intel-wired-lan] [PATCH v2 1/1] e1000e: Enable GPT clock
 before sending message to CSME
In-Reply-To: <20220508070905.1878172-1-sasha.neftin@intel.com>
References: <20220508070905.1878172-1-sasha.neftin@intel.com>
Message-ID: <f9909e7c-abfb-2638-b941-ca2a5e7e120c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 5/8/2022 10:09, Sasha Neftin wrote:
> On corporate (CSME) ADL systems, the Ethernet Controller may stop working
> ("HW unit hang") after exiting from the s0ix state. The reason is that
> CSME misses the message sent by the host. Enabling the dynamic GPT clock
> solves this problem. This clock is cleared upon HW initialization.
> 
> Fixes: 3e55d231716e ("e1000e: Add handshake with the CSME to support S0ix")
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=214821
> Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
> v2:
> Correct commit message and minor fix in comment.
>   drivers/net/ethernet/intel/e1000e/netdev.c | 4 ++++
>   1 file changed, 4 insertions(+)
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
