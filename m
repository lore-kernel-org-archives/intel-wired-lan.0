From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 8 Dec 2021 13:37:54 -0800
Subject: [Intel-wired-lan] [RFC PATCH 0/4] r8169: support dash
In-Reply-To: <67d7f6f7b6e84af692bc0a7c4c48bb84@realtek.com>
References: <20211129101315.16372-381-nic_swsd@realtek.com>
 <20211129095947.547a765f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <918d75ea873a453ab2ba588a35d66ab6@realtek.com>
 <20211130190926.7c1d735d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <d3a1e1c469844aa697d6d315c9549eda@realtek.com>
 <20211203070410.1b4abc4d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <e2fd429a489545e7a521283600cb7caa@realtek.com>
 <20211207202101.3a3a93b0@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <67d7f6f7b6e84af692bc0a7c4c48bb84@realtek.com>
Message-ID: <20211208133754.3809bb5e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 8 Dec 2021 07:53:28 +0000 Hayes Wang wrote:
> Jakub Kicinski <kuba@kernel.org>
> > Sent: Wednesday, December 8, 2021 12:21 PM  
> > > Could devlink param be used for more than 4 bytes settings?
> > > At least the IPv6 address is longer.  
> > 
> > We can add a new devlink sub-command and driver callback in that case.  
> 
> Excuse me. Do you mean someone will add it? Then, I could use it.
> Or, I have to add it.

You'd need to write all the code.

> > > Besides, we need the information of SMBIOS which could
> > > be 4K ~ 8K bytes data. Is there any way we could transmit
> > > it to firmware?  
> > 
> > Is structure of that data defined by some DMTF standard?  
> Yes.

That's good, as long as the kernel parses and validates the messages
the exact interface to user space does not matter that much.
