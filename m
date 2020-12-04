From: Toke =?unknown-8bit?q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Fri, 04 Dec 2020 18:26:10 +0100
Subject: [Intel-wired-lan] [PATCH v2 bpf 0/5] New netdev feature flags
 for XDP
In-Reply-To: <20201204092012.720b53bf@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
References: <20201204102901.109709-1-marekx.majtyka@intel.com>
 <20201204092012.720b53bf@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
Message-ID: <87k0tx7aa5.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Jakub Kicinski <kuba@kernel.org> writes:

> On Fri,  4 Dec 2020 11:28:56 +0100 alardam at gmail.com wrote:
>>  * Extend ethtool netlink interface in order to get access to the XDP
>>    bitmap (XDP_PROPERTIES_GET). [Toke]
>
> That's a good direction, but I don't see why XDP caps belong in ethtool
> at all? We use rtnetlink to manage the progs...

You normally use ethtool to get all the other features a device support,
don't you? And for XDP you even use it to configure the number of
TXQs.

I mean, it could be an rtnetlink interface as well, of course, but I
don't think it's completely weird if this goes into ethtool...

-Toke

