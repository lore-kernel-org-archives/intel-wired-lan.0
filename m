From: Skidmore, Donald C <donald.c.skidmore@intel.com>
Date: Mon, 2 May 2016 21:33:26 +0000
Subject: [Intel-wired-lan] NULL dereference on v4.1.x while enabling VF
In-Reply-To: <CAJ75kXZV32hLzYY-dynYAj6NHm2xNoq89inmSSbqUyxPvUazEw@mail.gmail.com>
References: <CAJ75kXZV32hLzYY-dynYAj6NHm2xNoq89inmSSbqUyxPvUazEw@mail.gmail.com>
Message-ID: <F6FB0E698C9B3143BDF729DF2228664691EA68EC@ORSMSX116.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of William Dauchy
> Sent: Monday, May 02, 2016 1:26 PM
> To: NETDEV <netdev@vger.kernel.org>; intel-wired-lan at lists.osuosl.org
> Cc: Alex Duyck <aduyck@mirantis.com>
> Subject: [Intel-wired-lan] NULL dereference on v4.1.x while enabling VF
> 
> Hello,
> 
> I am getting a NULL dereference on v4.1.x while enabling VF on a ixgbe (
> Intel Corporation 82599ES 10-Gigabit) card during boot.
> It seems to be related to a race since I don't have the issue if I test it a few
> seconds after boot. I had the same issue while testing on v4.5.x What can I
> do to help debug the issue?
> 
> ip link set dev eth0 up
> echo 32 > /sys/class/net/eth0/device/sriov_numvfs

Hey William,

Thanks for reporting the dereference.  Could you provide a little more detail on how you created this issue?  Are you just running the two commands (ip, sriov_numvfs) in some rc script and if you put a few second sleep in front of it you don't see the failure?

Thanks,
-Don Skidmore <donald.c.skidmore@intel.com>

