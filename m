From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 14 Sep 2020 16:06:02 -0700
Subject: [Intel-wired-lan] [RFC PATCH net-next v1 10/11]
 drivers/net/ethernet: remove incorrectly formatted doc
In-Reply-To: <20200911162557.000002d2@intel.com>
References: <20200911012337.14015-1-jesse.brandeburg@intel.com>
 <20200911012337.14015-11-jesse.brandeburg@intel.com>
 <fbd1fdd9-1000-8aac-7e5c-bc761b2209e1@intel.com>
 <20200911162557.000002d2@intel.com>
Message-ID: <3e3a63bd-dd6e-09a1-a1ad-29e7a7ed5d1f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 9/11/2020 4:25 PM, Jesse Brandeburg wrote:
> Jacob Keller wrote:
> 
>> A lot of these look like they should probably just be converted to use
>> kdoc format instead of removing the '/**'
> 
> I understand why you're saying that, and I spent a considerable amount
> of time fixing drivers that appeared to *try* to use kdoc but messed
> up. However, if they don't have anything that looks like doxygen or
> kdoc, then I just removed the "/**" to a /* and stopped kdoc processing.
> 
> The temac driver is a good example of not actually trying to kdoc at
> all.
> 
> However I will look over the patches and see if I see @brief anywhere
> that is left and try to fix those up. I've done so much now I might as
> well finish it, but the @brief doxygen style notes had never been
> processed into kdoc before, so changing the /** into /* doesn't
> actually remove any value, just makes the build clean.
> 

Sure, I think that's important. I just wanted to point out that we are
probably breaking whoever maintained/wrote that code and used doxygen.
(Since as far as I understand, doxygen also relies on the /** to find
comments).

Basically: I think we should be clear that is what we are doing:

  "We support kdoc, not doxygen, so if you want this, use kdoc format"

Thanks,
Jake
