From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Mon, 26 Feb 2018 16:40:06 -0800
Subject: [Intel-wired-lan] [next-queue PATCH 7/8] igb: Add support for
 adding offloaded clsflower filters
In-Reply-To: <9F146DDF-A3CC-404D-AA36-F4A4E444DD2D@gmail.com>
References: <20180224012036.5834-1-vinicius.gomes@intel.com>
 <20180224012036.5834-8-vinicius.gomes@intel.com>
 <9F146DDF-A3CC-404D-AA36-F4A4E444DD2D@gmail.com>
Message-ID: <87lgff9sex.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

Florian Fainelli <f.fainelli@gmail.com> writes:

> On February 23, 2018 5:20:35 PM PST, Vinicius Costa Gomes <vinicius.gomes@intel.com> wrote:
>>This allows filters added by tc-flower and specifying MAC addresses,
>>Ethernet types, and the VLAN priority field, to be offloaded to the
>>controller.
>>
>>This reuses most of the infrastructure used by ethtool, ethtool can be
>>used to read these filters, but modification and deletion can only be
>>done via tc-flower.
>
> You would want to check what other drivers supporting both
> ethtool::rxnfc and cls_flower do, but this can be seriously confusing
> to an user. As an user I would be more comfortable with seeing only
> rules added through ethtool via ethtool and those added by cls_flower
> via cls_flower. They will both access a shared set of resources but it
> seems easier for me to dump rules with both tools to figure out why
> -ENOSPC was returned rather than seeing something I did not add.
> Others might see it entirely differently.

I took a closer look at mlx5 and i40e, and they seem to use different
hardware capabilities (even incompatible in the case of i40e, which
returns an error when tring to add cls_flower filter when an ethtool
based filter exists) for ethtool and cls_flower. So I don't think the
model applies exactly here.

As they keep the filters separated for the user perspective, I could do
the same, in the name of convention, it's just that the separation is
more "artificial". But I have no strong opinions either way.

>
> If you added the ability for cls_flower to indicate a queue number and
> either a fixed rule index or auto-placement (RX_CLS_LOC_ANY), could
> that eliminate entirely the need for adding MAC address steering in
> earlier patches?

I am not sure that I understand. 'cls_flower' already has support for
indicating a queue number (expressed via the 'hw_tc' parameter to tc)
(commit 384c181e3780 ("net: sched: Identify hardware traffic classes
using classid").

And adding more control for the allocation of indexes for the rules seem
not to help much in reducing the size/complexity of this series. I.e.
this series has 4 parts: bug fixes, adding support for source addresses
for MAC filters, adding ethtool support MAC address filters (as it was
only missing some glue code), and adding offloading for some types of
cls_flower filters. More control for the allocation of rule indexes would
only affect the cls_flower part.

But perhaps I could be missing something here.

>
> -- 
> Florian
