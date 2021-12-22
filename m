From: Jonathan Toppins <jtoppins@redhat.com>
Date: Wed, 22 Dec 2021 11:35:52 -0500
Subject: [Intel-wired-lan] [PATCH v3 intel-next] ice: Fix E810 PTP reset
 flow
In-Reply-To: <20211220141852.695800-1-karol.kolacinski@intel.com>
References: <20211220141852.695800-1-karol.kolacinski@intel.com>
Message-ID: <e665d7d1-56ec-2f1b-ced6-2103336957cf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12/20/21 09:18, Karol Kolacinski wrote:
> The PF reset does not reset PHC and PHY clocks so it's unnecessary to
> stop them and reinitialize after the reset.
> Configuring timestamping changes the VSI fields so it needs to be
> performed after VSIs are initialized, which was not done in case of a
> reset.
> 
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>

Reviewed-by: Jonathan Toppins <jtoppins@redhat.com>

