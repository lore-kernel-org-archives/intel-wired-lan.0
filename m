From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 15 Feb 2016 20:41:53 -0800
Subject: [Intel-wired-lan] [PATCH 3/6] fm10k: use
 ethtool_rxfh_indir_default for default redirection table
In-Reply-To: <1455144351-14758-3-git-send-email-jacob.e.keller@intel.com>
References: <1455144351-14758-1-git-send-email-jacob.e.keller@intel.com>
 <1455144351-14758-3-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1455597713.7797.4.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2016-02-10 at 14:45 -0800, Jacob Keller wrote:
> The fm10k driver used its own code for generating a default
> indirection
> table on device load, which was not the same as the default generated
> by
> ethtool when indir_size of 0 is passed to SRXFH. Take advantage of
> ethtool_rxfh_indir_default() and simplify code to write the
> redirection
> table to reduce some code duplication.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> ?drivers/net/ethernet/intel/fm10k/fm10k.h???????? |? 2 ++
> ?drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 37
> ++++++++++++++----------
> ?drivers/net/ethernet/intel/fm10k/fm10k_main.c??? | 24 +++++++-------
> -
> ?3 files changed, 34 insertions(+), 29 deletions(-)

Another patch which causes compile errors, dropping patch. ?All patches
must pass the following:

make allmodconfig
make

before they can be submitted for kernel inclusion.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160215/91c0584a/attachment.asc>
