From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Tue, 18 Apr 2017 12:03:24 -0700
Subject: [Intel-wired-lan] NFS over NAT causes e1000e transmit hangs
In-Reply-To: <42af0e78-3107-1605-f8e1-d73a8c441ff0@gmail.com>
References: <42af0e78-3107-1605-f8e1-d73a8c441ff0@gmail.com>
Message-ID: <1492542204.10587.138.camel@edumazet-glaptop3.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2017-04-18 at 11:18 -0700, Florian Fainelli wrote:
> Hi,
> 
> I am using NFS over a NAT with two e1000e adapters and with eth1 being
> the LAN interface and eth0 the WAN interface. The kernel is Ubuntu's
> 16.10 kernel: 4.8.0-46-generic. The device doing NAT over NFS is just
> mounting a remote folder and doing normal execution/file accesses. It's
> enough to untar a file from this device onto a NFS share to expose the
> problem.
> 
> The transmit hangs look like the ones below, doing a rmmod/insmod does
> not help eliminated the problem, nor does a power cycle. Stopping the
> NFS over NAT definitively does let the adapter recover.

Is this NFS over TCP or UDP ?

Thanks !


