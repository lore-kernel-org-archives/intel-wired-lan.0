From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Fri, 15 Dec 2017 11:20:58 -0800
Subject: [Intel-wired-lan] [PATCH v2 next-queue 08/10] ixgbe: process
 the Tx ipsec offload
In-Reply-To: <7fe36ce0-be09-828d-16e5-776add0a182d@oracle.com>
References: <1513121823-27944-1-git-send-email-shannon.nelson@oracle.com>
 <1513121823-27944-9-git-send-email-shannon.nelson@oracle.com>
 <CAKgT0UfopVkcum1v5AcnY4BCRTjV7WGiCmMEUr73sx21Zzojrw@mail.gmail.com>
 <7fe36ce0-be09-828d-16e5-776add0a182d@oracle.com>
Message-ID: <20171215112058.00007963@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 12 Dec 2017 21:45:13 -0800
Shannon Nelson <shannon.nelson@oracle.com> wrote:

> > Also you are still setting the TCP flag for these packets. I'm
> > wondering if the TCP flag is really needed. I get that your current
> > setup only runs on TCP flows but what about other types of flows?
> > Couldn't UDP be encapsulated via ESP?  
> 
> That L4T_TCP bit annoys me - if I don't set it, the offload doesn't 
> work, whether doing csum offload or not.
> 
> The UDP messages can be encapsulated, but they don't seem to go down the 
> offload route.  I haven't looked into why yet.

L4T_TCP, AFAIK is a control of whether or not the L4 checksum generated
by the offload hardware uses the "never equal 0" logic required by TCP
checksums, but not required by UDP checksums.  Not sure if that helps,
or even really applies to the case where you're doing IPSEC offload.
Seems like something else is at play as well (undocumented HW
requirements?)
