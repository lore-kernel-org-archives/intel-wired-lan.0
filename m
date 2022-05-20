From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Fri, 20 May 2022 09:22:18 +0000
Subject: [Intel-wired-lan] [PATCH net-next v5 08/11] igc: Add support
 for setting frame preemption configuration
In-Reply-To: <20220520011538.1098888-9-vinicius.gomes@intel.com>
References: <20220520011538.1098888-1-vinicius.gomes@intel.com>
 <20220520011538.1098888-9-vinicius.gomes@intel.com>
Message-ID: <20220520092217.w4bw3pl6b5hum75g@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, May 19, 2022 at 06:15:35PM -0700, Vinicius Costa Gomes wrote:
> Set the hardware register that enables the frame preemption feature.
> 
> Some code is moved around because the PREEMPT_ENA bit in the
> IGC_TQAVCTRL register is recommended to be set after the individual
> queue registers (IGC_TXQCTL[i]) are set.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---

Could you please squash this patch with the previous one, which just
copies the settings from ethtool into the adapter but doesn't do
anything with them?
