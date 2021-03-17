From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Wed, 17 Mar 2021 09:36:24 -0700
Subject: [Intel-wired-lan] [net-next PATCH v2 02/10] intel: Update
 drivers to use ethtool_sprintf
In-Reply-To: <161594104491.5644.18446437902161792108.stgit@localhost.localdomain>
References: <161594093708.5644.11391417312031401152.stgit@localhost.localdomain>
 <161594104491.5644.18446437902161792108.stgit@localhost.localdomain>
Message-ID: <20210317093624.00005020@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Alexander Duyck wrote:

> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> Update the Intel drivers to make use of ethtool_sprintf. The general idea
> is to reduce code size and overhead by replacing the repeated pattern of
> string printf statements and ETH_STRING_LEN counter increments.
> 
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>

Thanks!

Acked-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
