From: Fujinaka, Todd <todd.fujinaka@intel.com>
Date: Tue, 30 Jun 2015 20:16:29 +0000
Subject: [Intel-wired-lan] [PATCH 1/1] igb: Use ARRAY_SIZE instead fo
 sizeof(a)/sizeof(a[0])
In-Reply-To: <CAFLxGvxayeac0Hq8Gi5j_TJ4dnboYypz9gchW0VQ0Z9t-UFofA@mail.gmail.com>
References: <1435640130-1466-1-git-send-email-maninder1.s@samsung.com>
 <9B4A1B1917080E46B64F07F2989DADD653571921@ORSMSX114.amr.corp.intel.com>
 <CAFLxGvxayeac0Hq8Gi5j_TJ4dnboYypz9gchW0VQ0Z9t-UFofA@mail.gmail.com>
Message-ID: <9B4A1B1917080E46B64F07F2989DADD653571BF0@ORSMSX114.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Sorry for the top-posting, but I'm provided with the tools they give me and bottom posting from Outlook just confuses email threads. Plus, this was crossposted all over creation and cc-ed to anyone with an intel address.

I still would say no if I'm allowed, because to guarantee that this change - that I don't think fixes anything - works in all cases, we need to do an incredible amount of regression testing. Every variant of every Intel part that uses this driver (and there are many) should be tested and will end up being used by the community.

Plus, you have no idea the number of obscure bugs I have to deal with as the guy answering customer questions. If this triggers some odd embedded compiler bug, I'm going to have to dig it out. Unless there is an actual bug, I'd like to leave it as it is.

Todd Fujinaka
Software Application Engineer
Networking Division (ND)
Intel Corporation
todd.fujinaka at intel.com
(503) 712-4565

-----Original Message-----
From: Richard Weinberger [mailto:richard.weinberger at gmail.com] 
Sent: Tuesday, June 30, 2015 12:01 PM
To: Fujinaka, Todd
Cc: Maninder Singh; Kirsher, Jeffrey T; Brandeburg, Jesse; Nelson, Shannon; Wyborny, Carolyn; Skidmore, Donald C; Vick, Matthew; Ronciak, John; Williams, Mitch A; intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; linux-kernel at vger.kernel.org; pankaj.m at samsung.com
Subject: Re: [Intel-wired-lan] [PATCH 1/1] igb: Use ARRAY_SIZE instead fo sizeof(a)/sizeof(a[0])

On Tue, Jun 30, 2015 at 4:53 PM, Fujinaka, Todd <todd.fujinaka@intel.com> wrote:
> I don't see the reason this is needed so I'm going to say NAK.

Using generic functions is always better than open coded stuff.
Linux's ARRAY_SIZE also makes sure that the passed variable is actually an array.

--
Thanks,
//richard
