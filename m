From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 11 Feb 2021 17:49:37 -0800
Subject: [Intel-wired-lan] 710/i40e, RSS and 802.1ad (double vlan)
In-Reply-To: <5ff376e94c76a9b475242d829ca7b7d2e1786620.camel@coverfire.com>
References: <fc55ca6fb012c9e36e53d2ab80d47894c38e85a8.camel@coverfire.com>
 <AB117487-C2C3-47EF-A3C4-FDCED9304282@intel.com>
 <8c7d255047890290948cf51450b1f860e013b48c.camel@coverfire.com>
 <d3f0614118192ba0df5ec0e845f61e092f187744.camel@coverfire.com>
 <20210209120223.000041ca@intel.com>
 <5ff376e94c76a9b475242d829ca7b7d2e1786620.camel@coverfire.com>
Message-ID: <20210211174937.00006632@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dan Siemon wrote:

> On Tue, 2021-02-09 at 12:02 -0800, Jesse Brandeburg wrote:
> > Please provide us with which driver/kernel/firmware you're running,
> > uname -a
> > ethtool -i ethx
> > lspci -vvv -s < your pci bus:dev.fn>
> 
> We are ok to update to the latest 710 firmware and we follow the kernel
> releases closely.
> 
> As we haven't had problems related to firmware, we still have many 710s
> in the field that are on 6.01 firmware. Below are dumps from a couple
> of our test boxes where I have upgraded the firmware.

Hi Dan, thanks for the detail, I think your firmware is new enough, but
I'm pretty sure our driver isn't configuring enough (it's currently an
unsupported feature in Linux i40e) to get it working. Newer than 6.01 is
all I know of that is required for firmware based on what I know right
now.

I've filed an internal issue tracker against i40e and sometime
(hopefully) soon we'll have the team looking into details. I don't have
any timeline for you currently, sorry.

I agree this is an important use case. We appreciate your reporting the
issue to us. Based on what I found when doing some initial triage, it
doesn't seem like a simple fix in the code, so I can't offer you a
patch to fix the issue like I wish I could.

Please keep us posted if you find any other relevant details, and I'll
try to update this thread if we find any info or get a test patch up
and running.

-Jesse
