From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Fri, 19 Feb 2021 13:13:19 -0800
Subject: [Intel-wired-lan] [Patch v4 00/18] Enable Intel VF flow
 director with DDP
In-Reply-To: <20210219130001.49600-1-haiyue.wang@intel.com>
References: <20210219130001.49600-1-haiyue.wang@intel.com>
Message-ID: <20210219131319.00000079@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Haiyue Wang wrote:

> The Intel E810 Series supports a programmable pipeline for a domain
> specific protocols classification, for example GTP by Dynamic Device
> Personalization (DDP) profile.
> 
> The E810 PF has introduced flex-bytes support by ethtool user-def option
> allowing for packet deeper matching based on an offset and value for DDP
> usage.
> 
> For making VF also benefit from this flexible protocol classification, some
> new virtchnl messages are defined and handled by PF, so VF can query this
> new flow director capability, and use ethtool with extending the user-def
> option to configure Rx flow classification.
> 
> The new user-def 0xAAAABBBBCCCCDDDD: BBBB is the 2 byte pattern while AAAA
> corresponds to its offset in the packet. Similarly DDDD is the 2 byte
> pattern with CCCC being the corresponding offset. The offset ranges from
> 0x0 to 0x1F7 (up to 504 bytes into the packet). The offset starts from
> the beginning of the packet.

Why must you use the ethtool user-def interface like this? I suspect
that you should be using tc-u32.

At the very least you should cover why you're *not* using u32 in the
cover letter, otherwise I'm sure the question will come up.

 
> This feature can be used to allow customers to set flow director rules
> for protocols headers that are beyond standard ones supported by ethtool
> (e.g. PFCP or GTP-U).
> 
> Like for matching GTP-U's TEID value 0x10203040:
> ethtool -N ens787f0v0 flow-type udp4 dst-port 2152 \
>


