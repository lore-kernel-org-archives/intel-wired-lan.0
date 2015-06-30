From: Alex Gartrell <alexgartrell@gmail.com>
Date: Tue, 30 Jun 2015 13:38:19 -0700
Subject: [Intel-wired-lan] [PATCH 1/1] igb: Use ARRAY_SIZE instead fo
	sizeof(a)/sizeof(a[0])
In-Reply-To: <9B4A1B1917080E46B64F07F2989DADD653571BF0@ORSMSX114.amr.corp.intel.com>
References: <1435640130-1466-1-git-send-email-maninder1.s@samsung.com>
 <9B4A1B1917080E46B64F07F2989DADD653571921@ORSMSX114.amr.corp.intel.com>
 <CAFLxGvxayeac0Hq8Gi5j_TJ4dnboYypz9gchW0VQ0Z9t-UFofA@mail.gmail.com>
 <9B4A1B1917080E46B64F07F2989DADD653571BF0@ORSMSX114.amr.corp.intel.com>
Message-ID: <CALCkm3cBn0O8+pZc+WW0QiAPf7X3vYo+CAe08OBssyidof3few@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Jun 30, 2015 at 1:16 PM, Fujinaka, Todd <todd.fujinaka@intel.com> wrote:

> I still would say no if I'm allowed, because to guarantee that this change - that I don't think fixes anything - works in all cases, we need to do an incredible amount of regression testing. Every variant of every Intel part that uses this driver (and there are many) should be tested and will end up being used by the community.
>

Validation is really simple: diff old_module.ko new_module.ko

And this is a good defensive measure, as it'll save you when someone
screws up and changes your array to a pointer to an array (you'll get
a build failure instead of 0).

-- 
Alex Gartrell <agartrell@fb.com>
