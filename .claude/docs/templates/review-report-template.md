# Review Report

## Critical Issues (Fix Now)

[Issues that **must** be fixed before proceeding]

- [ ] `file:line` - Issue description
  **Why critical**: [Security/data loss/broken functionality explanation]
  **Fix**: [Specific action to take]

**Example**:
```
- [ ] `backend/routes/activity.py:25` - Missing @require_auth decorator
  **Why critical**: Endpoint exposes user data without authentication check
  **Fix**: Add @require_auth decorator before route function definition
```

[If no critical issues: **None found** ✅]

---

## Warnings (Fix Before Merge)

[Issues that **should** be fixed but don't block deployment]

- [ ] `file:line` - Issue description
  **Impact**: [What happens if not fixed]
  **Fix**: [Specific action to take]

**Example**:
```
- [ ] `components/ActivityFeed.vue:45` - Missing empty state handling
  **Impact**: Users with no activity see blank screen (confusing UX)
  **Fix**: Add <div v-if="activities.length === 0">No recent activity</div>
```

[If no warnings: **None found** ✅]

---

## Suggestions (Optional)

[Nice-to-have improvements]

- [ ] `file:line` - Improvement idea
  **Why**: [Benefit if implemented]

**Example**:
```
- [ ] `backend/models/activity.py:12` - Consider adding index on user_id
  **Why**: Significantly faster queries as activity table grows
  **Trade-off**: Slightly slower inserts (minimal impact)
```

[If no suggestions: **None** 💡]

---

## Plan Adherence

[Checklist of plan phases and completion status]

- ✅ Phase 1: [Name] (complete)
- ✅ Phase 2: [Name] (complete)
- ⚠️ Phase 3: [Name] (partial - [what's missing])
- ⏳ Phase 4: [Name] (not started)

**Overall**: [X/Y phases complete]

**Incomplete tasks**:
- [Task 1 from tasks.md that's still pending]
- [Task 2 from tasks.md that's still pending]

---

## Security Review

[Specific security checks performed]

### Authentication/Authorization
- [ ] Protected routes have authentication? **✅ / ⚠️ / ❌**
- [ ] User data access is restricted? **✅ / ⚠️ / ❌**
- [ ] Authorization checks present? **✅ / ⚠️ / ❌**

### Input Validation
- [ ] User inputs validated? **✅ / ⚠️ / ❌**
- [ ] Query parameters validated? **✅ / ⚠️ / ❌**
- [ ] SQL injection prevented? **✅ / ⚠️ / ❌**

### XSS Prevention
- [ ] User strings escaped? **✅ / ⚠️ / ❌**
- [ ] v-html used safely? **✅ / ⚠️ / ❌**

### Error Handling
- [ ] Errors caught gracefully? **✅ / ⚠️ / ❌**
- [ ] Error messages safe? **✅ / ⚠️ / ❌**

---

## Verification Commands

[Commands to run to verify implementation]

```bash
# Run backend tests
[test command]

# Run frontend build
[build command]

# Start development environment
[dev server command]

# Manual verification steps
[step 1]
[step 2]
[step N]
```

**Example**:
```bash
# Run backend tests
pytest backend/tests/test_activity.py

# Build frontend
cd frontend && npm run build

# Manual test - check activity endpoint
curl -H "Authorization: Bearer <token>" \\
     http://localhost:8000/api/users/me/activity

# Manual test - pagination
curl -H "Authorization: Bearer <token>" \\
     "http://localhost:8000/api/users/me/activity?offset=10&limit=5"
```

---

## Overall Assessment

**Status**: [Ready to ship / Needs critical fixes / Needs warnings fixed]

**Summary**:
- 🚨 [N] critical issue(s)
- ⚠️  [M] warning(s)
- 💡 [K] suggestion(s)

**Next steps**:
1. [Step 1]
2. [Step 2]
3. [Step N]

**Example**:
```
**Status**: Needs critical fixes

**Summary**:
- 🚨 1 critical issue (missing auth)
- ⚠️  2 warnings (error handling, empty state)
- 💡 3 suggestions (performance optimizations)

**Next steps**:
1. Fix critical authentication issue
2. Fix warnings before merging to main
3. Consider implementing suggestions
4. Re-run /validate after fixes
```

---

## Notes

[Additional review notes, patterns observed, etc.]
