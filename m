From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Fri, 2 Feb 2018 13:21:38 -0800
Subject: [Intel-wired-lan] Possible read-modify-write bug in ixgbe x550
 phy setup
In-Reply-To: <87618083B2453E4A8714035B62D67992CC0DE506@FMSMSX105.amr.corp.intel.com>
References: <59b6e262-8027-675c-f75e-3a95d3a97e4f@oracle.com>
 <87618083B2453E4A8714035B62D67992CC0DE147@FMSMSX105.amr.corp.intel.com>
 <4d969de9-ad06-e696-21c1-74be9e03d2f7@oracle.com>
 <87618083B2453E4A8714035B62D67992CC0DE252@FMSMSX105.amr.corp.intel.com>
 <87618083B2453E4A8714035B62D67992CC0DE506@FMSMSX105.amr.corp.intel.com>
Message-ID: <be943ec5-8bc9-e50f-4b07-b5e9b3e98d56@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2/2/2018 1:08 PM, Tantilov, Emil S wrote:
> Just FYI - we looked at the reads and confirmed that there is no functional
> bug in the code because as it happens the CX1/SR bits is the only bits that
> are read and set and as such we don't lose any data. This of course means
> that the read is not needed and we'll just remove it.

Great - I'm glad to see it happens to work.  You might think about 
keeping that read for future safety and fixing the '=', but I'm not 
going to worry about it.

sln

