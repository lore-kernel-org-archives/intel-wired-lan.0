From: Florian Fainelli <f.fainelli@gmail.com>
Date: Fri, 23 Feb 2018 20:45:44 -0800
Subject: [Intel-wired-lan] [next-queue PATCH 7/8] igb: Add support for
 adding offloaded clsflower filters
In-Reply-To: <20180224012036.5834-8-vinicius.gomes@intel.com>
References: <20180224012036.5834-1-vinicius.gomes@intel.com>
 <20180224012036.5834-8-vinicius.gomes@intel.com>
Message-ID: <9F146DDF-A3CC-404D-AA36-F4A4E444DD2D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On February 23, 2018 5:20:35 PM PST, Vinicius Costa Gomes <vinicius.gomes@intel.com> wrote:
>This allows filters added by tc-flower and specifying MAC addresses,
>Ethernet types, and the VLAN priority field, to be offloaded to the
>controller.
>
>This reuses most of the infrastructure used by ethtool, ethtool can be
>used to read these filters, but modification and deletion can only be
>done via tc-flower.

You would want to check what other drivers supporting both ethtool::rxnfc and cls_flower do, but this can be seriously confusing to an user. As an user I would be more comfortable with seeing only rules added through ethtool via ethtool and those added by cls_flower via cls_flower. They will both access a shared set of resources but it seems easier for me to dump rules with both tools to figure out why -ENOSPC was returned rather than seeing something I did not add. Others might see it entirely differently.

If you added the ability for cls_flower to indicate a queue number and either a fixed rule index or auto-placement (RX_CLS_LOC_ANY), could that eliminate entirely the need for adding MAC address steering in earlier patches?

-- 
Florian
