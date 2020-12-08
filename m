From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Mon, 07 Dec 2020 16:24:02 -0800
Subject: [Intel-wired-lan] [PATCH net-next v1 1/9] ethtool: Add support
 for configuring frame preemption
In-Reply-To: <20201207152126.6f3d1808@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
References: <20201202045325.3254757-1-vinicius.gomes@intel.com>
 <20201202045325.3254757-2-vinicius.gomes@intel.com>
 <20201205094325.790b187f@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
 <87eek11d23.fsf@intel.com>
 <20201207152126.6f3d1808@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
Message-ID: <87blf5ywkd.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Jakub Kicinski <kuba@kernel.org> writes:

> On Mon, 07 Dec 2020 14:11:48 -0800 Vinicius Costa Gomes wrote:
>> Jakub Kicinski <kuba@kernel.org> writes:
>> >> + * @min_frag_size_mult: Minimum size for all non-final fragment size,
>> >> + * expressed in terms of X in '(1 + X)*64 + 4'  
>> >
>> > Is this way of expressing the min frag size from the standard?
>> >  
>> 
>> The standard has this: "A 2-bit integer value indicating, in units of 64
>> octets, the minimum number of octets over 64 octets required in
>> non-final fragments by the receiver" from IEEE 802.3br-2016, Table
>> 79-7a.
>
> Thanks! Let's drop the _mult suffix and add a mention of this
> controlling the addFragSize variable from the standard. Perhaps 
> it should in fact be called add_frag_size (with an explanation 
> that the "additional" means "above the 64B" which are required in
> Ethernet, and which are accounted for by the "1" in the 1 + X
> formula)?

Sounds good :-) Will add a comment with the standard reference and
change the name to 'add_frag_size'.


Cheers,
-- 
Vinicius
