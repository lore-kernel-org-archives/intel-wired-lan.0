From: William Dauchy <wdauchy@gmail.com>
Date: Mon, 9 May 2016 18:08:01 +0200
Subject: [Intel-wired-lan] NULL dereference on v4.1.x while enabling VF
In-Reply-To: <F6FB0E698C9B3143BDF729DF2228664691EA7CAF@ORSMSX116.amr.corp.intel.com>
References: <CAJ75kXZV32hLzYY-dynYAj6NHm2xNoq89inmSSbqUyxPvUazEw@mail.gmail.com>
 <F6FB0E698C9B3143BDF729DF2228664691EA68EC@ORSMSX116.amr.corp.intel.com>
 <CAJ75kXY_PMK0iTyM5bbhQoAS9je5AqpW67jyZpJEUoNw0BPcqw@mail.gmail.com>
 <F6FB0E698C9B3143BDF729DF2228664691EA7CAF@ORSMSX116.amr.corp.intel.com>
Message-ID: <CAJ75kXYH+Ni5tJv1Qobvx5uaibjvmTxHOiU6wDpdbD89r0Xx_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello Hello Don,

Thank you for your help.

On Fri, May 6, 2016 at 6:26 PM, Skidmore, Donald C
<donald.c.skidmore@intel.com> wrote:
> My validation hasn't be able to recreate the dereference on v4.1.x, v4.5.x or net_next.  Where exactly did you place the two line script in your rc scripts.  Our validation was able to run it as soon as ~14 second after the first boot message logged in dmesg.  Is this anywhere close to where you were executing it?  Likewise he has attempted running at both run level 3 and 5 in case that changed any of the times of how soon the rc scripts are executed.  So the more detail you can give of setup the more it might help us recreate what you are seeing.

my script is called right at the beginning of "start" from
/etc/init.d/networking in debian jessie; so before network init.
(first trace is 40s after boot in my test)
I can't find any other details I could gave you for now but I will let
you know if I think about something else.

-- 
William
