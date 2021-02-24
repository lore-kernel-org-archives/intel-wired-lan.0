From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Wed, 24 Feb 2021 00:53:57 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove no need includes
 from igc_mac.h
In-Reply-To: <20210223121923.1503421-1-sasha.neftin@intel.com>
References: <20210223121923.1503421-1-sasha.neftin@intel.com>
Message-ID: <8fd63311fdf508b9a7cdcd468a18cbdda6332682.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2021-02-23 at 14:19 +0200, Sasha Neftin wrote:
> igc_defines.h and igc_phy.h included in igc_hw.h
> Therefore no need to include these headers in igc_mac.h
> where is include igc_hw.h

From the submit-checklist, we don't want to be relying on other files'
includes.

	If you use a facility then #include the file that
defines/declares
	that facility.  Don't depend on other header files pulling in
ones
	that you use.
	
https://www.kernel.org/doc/Documentation/process/submit-checklist.rst

Though we aren't perfect in this, we shouldn't be removing this as it's
desired.

Thanks,
Tony
