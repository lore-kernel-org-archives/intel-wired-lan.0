From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Tue, 30 Jun 2015 21:01:17 +0200
Subject: [Intel-wired-lan] [PATCH 1/1] igb: Use ARRAY_SIZE instead fo
	sizeof(a)/sizeof(a[0])
In-Reply-To: <9B4A1B1917080E46B64F07F2989DADD653571921@ORSMSX114.amr.corp.intel.com>
References: <1435640130-1466-1-git-send-email-maninder1.s@samsung.com>
 <9B4A1B1917080E46B64F07F2989DADD653571921@ORSMSX114.amr.corp.intel.com>
Message-ID: <CAFLxGvxayeac0Hq8Gi5j_TJ4dnboYypz9gchW0VQ0Z9t-UFofA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Jun 30, 2015 at 4:53 PM, Fujinaka, Todd <todd.fujinaka@intel.com> wrote:
> I don't see the reason this is needed so I'm going to say NAK.

Using generic functions is always better than open coded stuff.
Linux's ARRAY_SIZE also makes sure that the passed variable is actually
an array.

-- 
Thanks,
//richard
