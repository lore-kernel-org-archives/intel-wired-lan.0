From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 13 Oct 2015 09:50:09 -0700
Subject: [Intel-wired-lan] [next-queue v2 2/6] i40e: add missing
 kernel-doc argument
In-Reply-To: <1444719992-301-2-git-send-email-sakiwit@gmail.com>
References: <1444719992-301-1-git-send-email-sakiwit@gmail.com>
 <1444719992-301-2-git-send-email-sakiwit@gmail.com>
Message-ID: <20151013095009.000045d7@unknown>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 13 Oct 2015 01:06:28 -0600
J?an Sacren <sakiwit@gmail.com> wrote:

> From: Jean Sacren <sakiwit@gmail.com>
> 
> The following kernell-doc arguments for their respective functions are
> missing:
> 
> 1) @cd_type_cmd_tso_mss for i40e_tso();
> 2) @cd_type_cmd_tso_mss for i40e_tsyn();
> 3) @tx_ring for i40e_tx_enable_csum().
> 
> Add them all for the kernel-doc requirement.
> 
> Signed-off-by: Jean Sacren <sakiwit@gmail.com>
> ---
> v2: No changes except for the serial number.

Acked-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
