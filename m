From: ira.weiny@intel.com <ira.weiny@intel.com>
Date: Fri,  9 Oct 2020 12:49:37 -0700
Subject: [Intel-wired-lan] [PATCH RFC PKS/PMEM 02/58] x86/pks/test: Add
 testing for global option
In-Reply-To: <20201009195033.3208459-1-ira.weiny@intel.com>
References: <20201009195033.3208459-1-ira.weiny@intel.com>
Message-ID: <20201009195033.3208459-3-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Ira Weiny <ira.weiny@intel.com>

Now that PKS can be enabled globaly (for all threads) add a test which
spawns a thread and tests the same PKS functionality.

The test enables/disables PKS in 1 thread while attempting to access the
page in another thread.  We use the same test array as in the 'local'
PKS testing.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 arch/x86/mm/fault.c |   4 ++
 lib/pks/pks_test.c  | 128 +++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 124 insertions(+), 8 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 4b4ff9efa298..4c74f52fbc23 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1108,6 +1108,10 @@ static int spurious_kernel_fault_check(unsigned long error_code, pte_t *pte,
 		if (global_pkey_is_enabled(pte, is_write, irq_state))
 			return 1;
 
+		/*
+		 * NOTE: This must be after the global_pkey_is_enabled() call
+		 * to allow the fixup code to be tested.
+		 */
 		if (handle_pks_testing(error_code, irq_state))
 			return 1;
 
diff --git a/lib/pks/pks_test.c b/lib/pks/pks_test.c
index 286c8b8457da..dfddccbe4cb6 100644
--- a/lib/pks/pks_test.c
+++ b/lib/pks/pks_test.c
@@ -154,7 +154,8 @@ static void check_exception(irqentry_state_t *irq_state)
 	}
 
 	/* Check the exception state */
-	if (!check_pkrs(test_armed_key, PKEY_DISABLE_ACCESS)) {
+	if (!check_pkrs(test_armed_key,
+			PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE)) {
 		pr_err("     FAIL: PKRS cache and MSR\n");
 		test_exception_ctx->pass = false;
 	}
@@ -308,24 +309,29 @@ static int test_it(struct pks_test_ctx *ctx, struct pks_access_test *test, void
 	return ret;
 }
 
-static int run_access_test(struct pks_test_ctx *ctx,
-			   struct pks_access_test *test,
-			   void *ptr)
+static void set_protection(int pkey, enum pks_access_mode mode, bool global)
 {
-	switch (test->mode) {
+	switch (mode) {
 		case PKS_TEST_NO_ACCESS:
-			pks_mknoaccess(ctx->pkey, false);
+			pks_mknoaccess(pkey, global);
 			break;
 		case PKS_TEST_RDWR:
-			pks_mkrdwr(ctx->pkey, false);
+			pks_mkrdwr(pkey, global);
 			break;
 		case PKS_TEST_RDONLY:
-			pks_mkread(ctx->pkey, false);
+			pks_mkread(pkey, global);
 			break;
 		default:
 			pr_err("BUG in test invalid mode\n");
 			break;
 	}
+}
+
+static int run_access_test(struct pks_test_ctx *ctx,
+			   struct pks_access_test *test,
+			   void *ptr)
+{
+	set_protection(ctx->pkey, test->mode, false);
 
 	return test_it(ctx, test, ptr);
 }
@@ -516,6 +522,110 @@ static void run_exception_test(void)
 		 pass ? "PASS" : "FAIL");
 }
 
+struct shared_data {
+	struct mutex lock;
+	struct pks_test_ctx *ctx;
+	void *kmap_addr;
+	struct pks_access_test *test;
+};
+
+static int thread_main(void *d)
+{
+	struct shared_data *data = d;
+	struct pks_test_ctx *ctx = data->ctx;
+
+	while (!kthread_should_stop()) {
+		mutex_lock(&data->lock);
+		/*
+		 * wait for the main thread to hand us the page
+		 * We should be spinning so hopefully we will not have gotten
+		 * the global value from a schedule in.
+		 */
+		if (data->kmap_addr) {
+			if (test_it(ctx, data->test, data->kmap_addr))
+				ctx->pass = false;
+			data->kmap_addr = NULL;
+		}
+		mutex_unlock(&data->lock);
+	}
+
+	return 0;
+}
+
+static void run_thread_access_test(struct shared_data *data,
+				   struct pks_test_ctx *ctx,
+				   struct pks_access_test *test,
+				   void *ptr)
+{
+	set_protection(ctx->pkey, test->mode, true);
+
+	pr_info("checking...  mode %s; write %s\n",
+			get_mode_str(test->mode), test->write ? "TRUE" : "FALSE");
+
+	mutex_lock(&data->lock);
+	data->test = test;
+	data->kmap_addr = ptr;
+	mutex_unlock(&data->lock);
+
+	while (data->kmap_addr) {
+		msleep(10);
+	}
+}
+
+static void run_global_test(void)
+{
+	struct task_struct *other_task;
+	struct pks_test_ctx *ctx;
+	struct shared_data data;
+	bool pass = true;
+	void *ptr;
+	int i;
+
+	pr_info("     ***** BEGIN: global pkey checking\n");
+
+	/* Set up context, data pgae, and thread */
+	ctx = alloc_ctx("global pkey test");
+	if (IS_ERR(ctx)) {
+		pr_err("     FAIL: no context\n");
+		pass = false;
+		goto result;
+	}
+	ptr = alloc_test_page(ctx->pkey);
+	if (!ptr) {
+		pr_err("     FAIL: no vmalloc page\n");
+		pass = false;
+		goto free_context;
+	}
+	other_task = kthread_run(thread_main, &data, "PKRS global test");
+	if (IS_ERR(other_task)) {
+		pr_err("     FAIL: Failed to start thread\n");
+		pass = false;
+		goto free_page;
+	}
+
+	memset(&data, 0, sizeof(data));
+	mutex_init(&data.lock);
+	data.ctx = ctx;
+
+	/* Start testing */
+	ctx->pass = true;
+
+	for (i = 0; i < ARRAY_SIZE(pkey_test_ary); i++) {
+		run_thread_access_test(&data, ctx, &pkey_test_ary[i], ptr);
+	}
+
+	kthread_stop(other_task);
+	pass = ctx->pass;
+
+free_page:
+	vfree(ptr);
+free_context:
+	free_ctx(ctx);
+result:
+	pr_info("     ***** END: global pkey checking : %s\n",
+		 pass ? "PASS" : "FAIL");
+}
+
 static void run_all(void)
 {
 	struct pks_test_ctx *ctx[PKS_NUM_KEYS];
@@ -538,6 +648,8 @@ static void run_all(void)
 	}
 
 	run_exception_test();
+
+	run_global_test();
 }
 
 static void crash_it(void)
-- 
2.28.0.rc0.12.gb6a658bd00c9

