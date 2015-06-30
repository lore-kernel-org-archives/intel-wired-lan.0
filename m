From: Joe Perches <joe@perches.com>
Date: Tue, 30 Jun 2015 15:32:40 -0700
Subject: [Intel-wired-lan] [PATCH 1/1] igb: Use ARRAY_SIZE instead fo
 sizeof(a)/sizeof(a[0])
In-Reply-To: <9B4A1B1917080E46B64F07F2989DADD653571DD7@ORSMSX114.amr.corp.intel.com>
References: <1435640130-1466-1-git-send-email-maninder1.s@samsung.com>
 <9B4A1B1917080E46B64F07F2989DADD653571921@ORSMSX114.amr.corp.intel.com>
 <CAFLxGvxayeac0Hq8Gi5j_TJ4dnboYypz9gchW0VQ0Z9t-UFofA@mail.gmail.com>
 <9B4A1B1917080E46B64F07F2989DADD653571BF0@ORSMSX114.amr.corp.intel.com>
 <9B4A1B1917080E46B64F07F2989DADD653571DD7@ORSMSX114.amr.corp.intel.com>
Message-ID: <1435703560.12101.51.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2015-06-30 at 22:25 +0000, Fujinaka, Todd wrote:
> I've submitted a version to intel-wired-lan that addresses the original
> issue as well as Joe Perches's suggestion to just delete the define.

Please cc netdev next time too.


