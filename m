From: William Dauchy <wdauchy@gmail.com>
Date: Tue, 3 May 2016 14:32:37 +0200
Subject: [Intel-wired-lan] NULL dereference on v4.1.x while enabling VF
In-Reply-To: <F6FB0E698C9B3143BDF729DF2228664691EA68EC@ORSMSX116.amr.corp.intel.com>
References: <CAJ75kXZV32hLzYY-dynYAj6NHm2xNoq89inmSSbqUyxPvUazEw@mail.gmail.com>
 <F6FB0E698C9B3143BDF729DF2228664691EA68EC@ORSMSX116.amr.corp.intel.com>
Message-ID: <CAJ75kXY_PMK0iTyM5bbhQoAS9je5AqpW67jyZpJEUoNw0BPcqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello Don,

Thank you for your reply.

On Mon, May 2, 2016 at 11:33 PM, Skidmore, Donald C
<donald.c.skidmore@intel.com> wrote:
> Thanks for reporting the dereference.  Could you provide a little more detail on how you created this issue?  Are you just running the two commands (ip, sriov_numvfs) in some rc script and if you put a few second sleep in front of it you don't see the failure?

Your understanding is correct; a rc script is run with ip and echo in
numvfs commands. I tried to reduce it to the minimum. If I put a sleep
20 in front of it, it does not crash. I also forgot to add I did not
had the issue in 3.14.x with the same script.

Best,
-- 
William
