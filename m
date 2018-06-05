From: Andre Tomt <andre@tomt.net>
Date: Tue, 5 Jun 2018 18:30:56 +0200
Subject: [Intel-wired-lan] [net-queue PATCH 0/2] More fixes for ipsec
In-Reply-To: <20180605150520.3359.94409.stgit@ahduyck-green-test.jf.intel.com>
References: <20180605150520.3359.94409.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <c184d37f-119c-9dc4-5fc8-cbb3b7170703@tomt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 05. juni 2018 17:11, Alexander Duyck wrote:
> This set addresses a few more issues for ipsec.
> 
> 1. We fix the bit definitions for the SECTXSTAT and SECRXSTAT registers.
> 2. Use those new definitions to test if fuse or strapping disabled ipsec.
> 3. Fix boolean logic testing for if we disabled it correctly in software.
> 4. Add additional test to avoid loopback and wait if it isn't needed.

Great, I will see if I can get these and the other fix tested on at 
least this Denverton and two (I think) unaffected Broadwell DE Xeon D 
15xx SFP+/10GbaseT variants later this evening.

Thanks
